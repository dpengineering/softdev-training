---
title: PyCharm Remote Development Setup
nav_order: 15
---

# Setting Up PyCharm for Remote Raspberry Pi Development

This guide walks you through configuring **PyCharm Professional** on Windows to connect to a Raspberry Pi over SSH, sync your local project files, and execute Python code remotely on the Pi.

## Prerequisites

* **PyCharm Professional Edition** installed on your Windows machine (Remote SSH deployment is a Pro feature).

* Your project repository/folder saved on your **My Desktop** (`M:\` network drive).

* Access to the local network where the Raspberry Pis are hosted.

## Step 1: Activate PyCharm Pro

Remote development features require PyCharm Professional.

1. Open PyCharm.

2. In the top-right corner of the Welcome screen (or main window), click the **Trial** / **Activate Free Trial** button.

3. Either start a **30-day free trial** or click **Activate PyCharm Pro** to log in using credentials provided by your mentor/instructor.

4. Restart PyCharm if prompted.

## Step 2: Find Your Raspberry Pi's IP Address

1. Open a web browser (e.g., Google Chrome).

2. Navigate to the local project dashboard URL:

   ```
   http://10.107.200.18
   ```

3. Locate your specific project name in the list of running devices (e.g., `tippymaze`).

4. Copy or note the **IP address** listed on the right side for your project (e.g., `10.107.200.31`).

## Step 3: Verify Connection & Create a Remote Directory

Next, test your network connection to the Pi and create a destination folder for your code.

1. In PyCharm, open the **Terminal** tool window at the bottom-left of the screen.

2. Click the dropdown arrow (`v`) next to the `+` icon and select **Git Bash** to open a bash terminal.

3. Ping your Raspberry Pi's IP address to ensure you are on the correct network:

   ```
   ping <YOUR_PI_IP_ADDRESS>
   # Example: ping 10.107.200.31
   ```

   *Verify that you receive replies with **0% loss**.*

4. Connect to the Raspberry Pi via SSH:

   ```
   ssh pi@<YOUR_PI_IP_ADDRESS>
   # Example: ssh pi@10.107.200.31
   ```

5. If prompted with *"Are you sure you want to continue connecting?"*, type `yes` and press **Enter**.

6. Enter the Pi password when prompted (ask your mentor if you don't have it).

   *(Note: Characters will not appear on screen as you type. Press **Enter** when finished.)*

7. Once logged in (`pi@<project-name>:~ $`), create a new directory on the Pi to store your training code:

   ```
   mkdir training-pi
   ```

8. Type `ls` and press **Enter** to verify that the `training-pi` folder was created.

## Step 4: Open Your Local Project from `My Desktop`

{: .warning }
Ensure your project folder is located on your **My Desktop (`M:\`)** network drive so your work is backed up properly.

1. In PyCharm, go to **File > Open...** (or click **Open** on the Welcome screen).

2. In the file explorer, navigate to **This PC** on the left sidebar and select **My Desktop (`M:`)**.

3. Select your project folder (e.g., `DPEA_DPI-dpealings`) and click **OK**.

4. Confirm that the path at the top of the Project panel (top left) starts with `M:\` (e.g., `M:\DPEA_DPI-dpealings`).

## Step 5: Configure the Remote SSH Python Interpreter

To run your code using the Raspberry Pi's hardware and Python environment rather than your Windows PC, you must configure a remote interpreter.

1. Open PyCharm **Settings**:

   * Press `Ctrl + Alt + S`, **OR**

   * Click the **Gear icon** (or hamburger menu) and select **Settings**.

2. In the left sidebar, navigate to **Project: <Your_Project_Name> > Python Interpreter**.

3. Click **Add Interpreter** (or the gear icon next to the interpreter dropdown) and select **On SSH...**.

4. **Configure SSH Server Details:**

   * Select **New**.

   * **Host:** Enter your Raspberry Pi's IP address (e.g., `10.107.200.31`).

   * **Username:** `pi`

   * Click **Next**.

5. **Authentication:**

   * Enter the Pi password (the same one you used for SSH in Step 3).

   * Click **Next** (PyCharm will test the connection and introspect the Pi).

6. **Configure Virtual Environment & Sync Folder:**

   * Select **Generate new** environment.

   * Set the **Type** to `uv` (or leave as default if `uv` is pre-selected).

   * Verify the remote virtual environment location matches `/home/pi/.virtualenvs/<your-project-name>`.

   * **Sync folders (Crucial Step):** Click the **Folder icon** next to *Sync folders* to map your local directory to the remote folder you created earlier:

     * **Local Path:** `M:\<your-project-folder>` (automatically filled)

     * **Remote Path:** Click the browse/folder icon, expand `/home/pi`, and select `training-pi`. Click **OK**.

7. Click **Create**.

PyCharm will now create the virtual environment and automatically upload your local project files to `/home/pi/training-pi` on the Raspberry Pi. You can verify the upload in the **File Transfer** panel at the bottom left of the screen.

## Step 6: Run Your Code Remotely

1. In the **Project** panel on the left, locate your main runner or script file (e.g., `dpealings/run.py`).

2. Right-click the file and select **Run 'run'**, or open the file and click the green **Play (`▶`)** button in the top-right toolbar.

3. Check the **Run** console output at the bottom of the screen. The top line should confirm execution via SSH on the Pi and look something like:

   ```
   ssh://pi@10.107.200.31:22/home/pi/.virtualenvs/DPEA_DPI-dpealings/bin/python -u /home/pi/training-pi/dpealings/run.py
   
   ```

4. Woohoo! Your remote development environment is ready!