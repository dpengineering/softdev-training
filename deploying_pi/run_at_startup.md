---
title: Run the App at Startup
nav_order: 14
---

# Run the App at Startup

<iframe width="720" height="405" src="https://www.youtube.com/embed/TKoac1ikUL0" frameborder="0" allowfullscreen></iframe>

This sets up two systemd services so an exhibit runs on its own when the Pi turns on:

- SERVICE-update pulls the latest main from GitHub at boot.
- SERVICE then runs main.py fullscreen on the desktop.

The exhibit runs from its own checkout in /opt/dpea/REPO_NAME, which gets reset to main on every boot. You develop in a separate checkout in ~/src/REPO_NAME, so your edits never fight with the running exhibit.

Throughout this page, REPO_NAME is the repo's exact name on GitHub and SERVICE is that name in lowercase. For example, Newtons-Cradle runs as newtons-cradle.

## Before you start

- The Pi is [flashed with the DPEA Raspberry Pi image](flash_sd_card.html) and is connected to the internet.
- The Pi has a [deploy key](deploying_to_rpi.html) for this repo.
- The repo is in the dpengineering org, uses uv (it has pyproject.toml and uv.lock), and the app starts from main.py at the repo root.

## 1. Add the deploy files to the repo

On your computer, make a deploy folder at the root of the repo with these four files:

```
deploy/
  setup.sh
  update.sh
  systemd/
    app.service
    app-update.service
```

| File                              | What it does                                                                                                |
|:----------------------------------|:------------------------------------------------------------------------------------------------------------|
| deploy/setup.sh                   | One-time setup. Clones the exhibit checkout, installs dependencies, and installs and enables both services. |
| deploy/update.sh                  | Runs at every boot. Resets the exhibit checkout to the latest main.                                         |
| deploy/systemd/app-update.service | Runs update.sh at boot once the network is up. Installed as SERVICE-update.service.                         |
| deploy/systemd/app.service        | Runs main.py after the update finishes. Installed as SERVICE.service.                                       |

Create each file and paste in the contents below. Hover over a block and click the copy button in its corner.

### deploy/setup.sh

After pasting, change REPO_NAME on line 5 to the repo's exact name on GitHub, for example REPO_NAME=Newtons-Cradle. Capitalization matters. This is the only line you change in any of the files.

```bash
{% include_relative deploy-template/setup.sh %}
```

### deploy/update.sh

```bash
{% include_relative deploy-template/update.sh %}
```

### deploy/systemd/app.service

```ini
{% include_relative deploy-template/systemd/app.service %}
```

### deploy/systemd/app-update.service

```ini
{% include_relative deploy-template/systemd/app-update.service %}
```

Make both scripts executable, then commit the deploy folder and push it to main:

```bash
chmod +x deploy/setup.sh deploy/update.sh
```

## 2. Clone a development checkout on the Pi

```bash
git clone git@github.com:dpengineering/REPO_NAME.git ~/src/REPO_NAME
```

This is where you edit and test on the Pi. Don't edit files in /opt/dpea/REPO_NAME, since the next boot erases them.

## 3. Run setup

```bash
~/src/REPO_NAME/deploy/setup.sh
```

Run it as your normal user, not with sudo. It asks for your password when it needs it. Setup:

- clones the exhibit checkout into /opt/dpea/REPO_NAME
- installs the exact dependency versions from uv.lock
- installs and enables SERVICE-update and SERVICE
- lets the app stop its own service without a password, for an admin Quit button
- logs in to the desktop at boot and turns off screen blanking

Then reboot:

```bash
sudo reboot
```

## 4. Check that it's running

The app should open fullscreen after the Pi boots. To check the services:

```bash
systemctl status SERVICE
```

Read this boot's logs, including why the app stopped:

```bash
journalctl -u SERVICE-update -b
journalctl -u SERVICE -b
```

## How updates work

Push to main, then reboot the Pi. On every boot, SERVICE-update fetches main and resets the exhibit checkout to it, then SERVICE starts the app.

- Without internet, the exhibit keeps running the code it already has.
- If the new commit's dependencies fail to install, it goes back to the previous commit.
- Files that git ignores, like a per-machine settings file, are never touched by updates.

## When the app exits

What the service does next depends on how the app exited:

| How the app exits | What happens |
|:--|:--|
| Normally (exit code 0), like pressing Escape on a keyboard | The service starts the app again after 3 seconds. |
| With an error, like an uncaught exception | The app stays off until the Pi is power-cycled, so a broken exhibit doesn't restart over and over. |
| The service is stopped | The app stays off until the Pi is power-cycled. |

### Admin Restart and Quit buttons

If the app has an admin screen, its Restart and Quit buttons use this behavior:

- **Restart** resets a misbehaving session. Make the hardware safe (stop motion, disable motors), then exit the app normally, for example with App.get_running_app().stop() in Kivy. The service brings it back.
- **Quit** turns the exhibit off until it's power-cycled. Exiting isn't enough, since the service would just restart it. Make the hardware safe, then stop the service. setup.sh lets the app run this one command without a password:

```python
import subprocess

subprocess.run(["sudo", "systemctl", "stop", "SERVICE.service"], check=True)
```

Replace SERVICE with the service name, like newtons-cradle.service.

## Working on the Pi

The running exhibit holds the hardware. Stop it before running your development checkout:

```bash
sudo systemctl stop SERVICE
```

Start it again when you're done:

```bash
sudo systemctl start SERVICE
```

{: .note }
Setup installs the services from the exhibit checkout, not your development checkout. After changing anything in deploy/systemd, push it to main, reboot so the exhibit checkout pulls it, then run setup.sh again and reboot.
