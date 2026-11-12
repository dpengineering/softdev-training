#!/bin/bash
set -euo pipefail

# Set this to the repo's exact name on GitHub.
REPO_NAME=Your-Repo-Name

SERVICE=${REPO_NAME,,}
REPO=git@github.com:dpengineering/$REPO_NAME.git
EXHIBIT_DIR=/opt/dpea/$REPO_NAME

fail() {
	echo "$1" >&2
	exit 1
}

[[ $EUID -ne 0 ]] || fail "Run setup.sh as the exhibit user, not root."
command -v uv >/dev/null || fail "uv is missing. Flash the DPEA Raspberry Pi image."

# Clone the exhibit checkout over the deploy key, or reuse one that already pulls from this repo.
if [[ -d $EXHIBIT_DIR/.git ]]; then
	origin=$(git -C "$EXHIBIT_DIR" remote get-url origin)
	[[ $origin == "$REPO" ]] || fail "$EXHIBIT_DIR pulls from $origin, expected $REPO."
else
	sudo install -d -o "$USER" -g "$(id -gn)" "$(dirname "$EXHIBIT_DIR")"
	git clone "$REPO" "$EXHIBIT_DIR"
fi
# Install the exact pinned dependencies into the checkout's .venv.
(cd "$EXHIBIT_DIR" && uv sync --locked --no-dev)

# Fill in this Pi's user, checkout path, and names, install both systemd units, and start them on every boot.
install_unit() {
	sed -e "s|@USER@|$USER|g" -e "s|@EXHIBIT_DIR@|$EXHIBIT_DIR|g" \
		-e "s|@SERVICE@|$SERVICE|g" -e "s|@REPO_NAME@|$REPO_NAME|g" \
		"$EXHIBIT_DIR/deploy/systemd/$1" | sudo tee "/etc/systemd/system/$2" >/dev/null
}
install_unit app-update.service "$SERVICE-update.service"
install_unit app.service "$SERVICE.service"
sudo systemctl daemon-reload
sudo systemctl enable "$SERVICE-update.service" "$SERVICE.service"

# Let the admin Quit button stop the service without a password. visudo checks the rule before it goes live.
sudoers=$(mktemp)
echo "$USER ALL=(root) NOPASSWD: /usr/bin/systemctl stop $SERVICE.service" >"$sudoers"
sudo visudo -cqf "$sudoers"
sudo install -m 440 "$sudoers" "/etc/sudoers.d/$SERVICE"
rm "$sudoers"

# Boot straight into the desktop the app draws on, and never blank the screen.
sudo raspi-config nonint do_boot_behaviour B4
sudo raspi-config nonint do_blanking 1

echo "Setup complete. Reboot to start $REPO_NAME."
