---
title: Steppers
layout: default
nav_order: 7
---

# Steppers
Now comes the fun part! We'll be running some hardware through the RPi on the DPi Computer Plus, First, watch the following videos to gain some background on some of the DPEA hardware and their various functions and operations.

## Videos

[The mechanisms behind motors]; Watch from 3 minutes to 8 minutes

[Some info about the Talons]

[The functions of a stepper]

[Servos]

## Introduction to control

Alright, it's now time to dive into the code to actually control steppers! 

You install the interactive shell version of python, ipython, for more detailed and verbose outputs. Ask a teacher for a DPi Stepper board, plug in the stepper motor into MOTOR 0, then connect DPi Stepper to the DPi Computer. Keep in mind that the orientation you plug things in does matter -- if you feel quite a bit of resistance, don't force connectors where they don't want to be! Ask a teacher or mentor for help. 

Let's now go through some basic stepper commands that you'll need to create your UI. 

All of this info can be found in the DPEA_DPi examples, linked here: https://github.com/dpengineering/DPEA_DPi/tree/HarlowDevelopment/DPi_Examples This repository also has annotated examples extending beyond just servos and steppers, which is helpful as you begin working on the unique hardware associated with your project. 

As you're working through these examples, PLEASE ENTER THESE COMMANDS IN AN INTERACTIVE SHELL ALONG WITH ME. If you just read these documents, it's hard to internalize anything that's going on (and also come on! Seeing things move is pretty sick)


Begin by defining your boilerplate. 

```py
from dpeaDPi.DPiComputer import DPiComputer
from dpeaDPi.DPiStepper import *
from time import sleep

# create the DPiStepper object, one object should be created for each DPiStepper
# board that you are using.
dpiStepper = DPiStepper()
```
You can technically chain 4 DPiStepper boards together through jumper cables, which would then assume addresses 0-3. By default, the board number is zero, and you'll have to power cycle after chaining to change that. In our case, we're dealing with one DPi Stepper board, which means that our board number will be zero. 
```py
dpiStepper.setBoardNumber(0)
```
For reference, most DPi library functions return True if the function executes successfully and False otherwise. That means it's best practice to check every function to see its return value, though that admittedly is a massive pain. At the minimum, however, it's recommended to check the first command sent to the board to check whether the connection to the board was established correctly. 
### Issues with the board
There are a couple reasons why your first command may be unsuccessful: 
 - The DPi board isn't powered.
 - The board isn't plugged into the DPiNetwork, or plugged in incorrectly. 
 - The network isn't terminated correctly. Termination jumpers must be set on the network's last board and none others. 
 - The board's LCD is displaying a menu or menu command. It is not at the home screen. (This one's important! It's a pretty common mistake)
 - The board number is set incorrectly 
 - You passed in a bad number or type of inputs to the DPi functions

### Back to code
 Now, for that aformentioned check. This initializes the board, but also serves as a method to determine whether our connection to the DPiStepper is alive and robust. 

 ```py
# Initialize the board to its default values.
if dpiStepper.initialize() != True:
    print("Communication with the DPiStepper board failed.")
```

Let's now enable the stepper motors, which will switch them from being freely rotating to locking their position. 
```py
dpiStepper.enableMotors(True)
```
### Microstepping
This is another important concept when addressing steppers. Microstepping determines the number of steps per revolution of the motor -- the choices for microstepping are 1, 2, 4, 8, 16, and 32. By choosing 1, the motor will require 200 steps to make one full rotation. Choosing 2 will require 400 steps, 8 will require 1600, and so on and so forth. More steps gives you greater angular resolution, smoother movement, and quieter motor movement, but places a larger load on the DPi Stepper board, which has to generate more steps for the same distance of motor movement. For most applications, 8 or 16 would be ideal, but you might want to **step** (haha yes i'm so funny) that down to 8, 4, or even 2 if your motor is moving particularly fast. 

Let's set our microstepping to 8. 
```py
microstepping = 8
dpiStepper.setMicrostepping(microstepping)
```
Let's also set motor speed and acceleration. A good starting point is always 1 rev/s, which is 1600 steps under our 8x microstepping we specified. Setting acceleration = speed is also often ideal and good practice. 

```py
speed_steps_per_second = 200 * microstepping
accel_steps_per_second_per_second = speed_steps_per_second
dpiStepper.setSpeedInStepsPerSecond(0, speed_steps_per_second)
dpiStepper.setSpeedInStepsPerSecond(1, speed_steps_per_second)
dpiStepper.setAccelerationInStepsPerSecondPerSecond(0, accel_steps_per_second_per_second)
dpiStepper.setAccelerationInStepsPerSecondPerSecond(1, accel_steps_per_second_per_second)
```
Check the status of the motor as well. Passing in 0 returns True on a successful communication, 1 returns True if the motor is stopped, 2 returns True if the motors are enabled, and 3 returns True if the homing switch indicates that your stepper is homed. All of these return False if these conditions are not met. 

```py
stepperStatus = dpiStepper.getStepperStatus(0)
print(f"Pos = {stepperStatus}")
```

### Movement
Now time for the fun part! Let's actually move a stepper. The following command will rotate Stepper 0 one full revolution, waiting for the motor to stop. 

```py
stepper_num = 0
steps = 1600
wait_to_finish_moving_flg = True
dpiStepper.moveToRelativePositionInSteps(stepper_num, steps, wait_to_finish_moving_flg)
```
Awesome! For reference, we're about half way there, so feel free to take a break if you so desire. 




{: .note }
## Kivy UI 
It's once again time for another Kivy UI (your favorite, I presume) You should use your intro Kivy UI as a starting place for this one. You should: 


1. Turn on and off a stepper motor with a button
2. Change the dirrection the stepper motor with a direction button
3. Change the speed the stepper motor runs at with a slider

Bonus challenge! 

4. Create a button that causes the stepper to turn as described: 
Throughout the course of the operation, create a label that outputs get_position_in_units to the kivy screen. Note that this should be dynamically updating while the stepper is in motion. 

15 turns revolutions clockwise at 1 revolution / sec. 
Stops 10 seconds then turns clockwise for 10 revolutions at 5 rev / sec. T
Stops for 8 seconds.
Then turns counter clockwise for 100 revolutions at 8 rev / sec. 
Then stops for 10 seconds and then goes home 





[The mechanisms behind motors]: https://www.youtube.com/watch?v=Rc892r--njw&t=703s
[Some info about the Talons]: https://www.youtube.com/watch?v=CIhEUkkgT44
[The functions of a stepper]: https://www.youtube.com/watch?v=eyqwLiowZiU
[Servos]: https://www.youtube.com/watch?v=LXURLvga8bQ
