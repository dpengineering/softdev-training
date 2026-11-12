#!/bin/bash
set -euo pipefail

main() {
	# Work from the repo root, and make git fail fast instead of prompting when GitHub is unreachable.
	cd "$(dirname "$(readlink -f "$0")")/.."
	export GIT_SSH_COMMAND="ssh -o BatchMode=yes -o ConnectTimeout=10"

	# Remember the running commit, and keep it if main can't be fetched (e.g. no internet).
	local previous
	previous=$(git rev-parse HEAD)
	if ! timeout 30 git fetch --quiet origin main; then
		echo "Fetch failed, keeping $(git rev-parse --short HEAD)"
		return
	fi

	# Make the checkout exactly match main, discarding any local edits.
	git reset --quiet --hard origin/main
	# If main's dependencies won't install, go back to the previous commit and its already-cached packages.
	if ! uv sync --locked --no-dev; then
		echo "uv sync failed at $(git rev-parse --short HEAD), restoring ${previous:0:7}" >&2
		git reset --quiet --hard "$previous"
		uv sync --locked --no-dev --offline
	fi
	echo "Running $(git rev-parse --short HEAD)"
}

main "$@"
exit
