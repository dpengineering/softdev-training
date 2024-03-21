---
title: Servos
layout: default
nav_order: 8
---
# Servos 
Alright, we'll essentially repeat the same thing, but with Servos. 

## PWM and additional background
First, a bit of context! This is just sort of interesting, but how exactly do you think the signal to control servos works? We only have one input wire, which seems like a lot of effort to then transmit bits over. 

But while it's difficult to transmit individual bits, it's less difficult to just modulate the signal, which creates a robust, efficient method for controlling the position of our Servo. This is known as *Pulse Width Modulation*, and is actually a super important technology for controlling motors, servos and more with limited inputs really fast. Some examples of the signal are shown below, with their corresponding servo position. 

We'll also be hooking up a limit switch, so you should also learn about debouncing, which is what we use to avoid "double pressing" on button input presses, given there's no feasible way for someone to consistently press and release a button within the interval of transmission of said button. Check it out here: https://learn.adafruit.com/make-it-switch/debouncing

{: .warning }
This is true for basically everything you do in the DPEA, but keep in mind that the hardware you're working with is very fragile! To avoid a mistake burning up 100s of dollars of hardware, remember to: 
{: .warning }
- Power down hardware while not using it.
- Ask a teacher whether hardware is connected correctly before powering it up. 
- Check for exposed wires or circuitry. 
- Think! Quite a few issues can be prevented if you remain conscious about all of our actions. This is difficult to do, but also very important.  

## Servo basics 
Let's step through some example code describing the process of operating a servo using the DPi board and a RPi. First, import pertinent utilities, and create a DPi Computer object: 
```py
from dpeaDPi.DPiComputer import *
from time import sleep

# Create a DPiComputer object
dpiComputer = DPiComputer()

# Initialize the board to its default values
dpiComputer.initialize()
```

As mentioned before, serve are nice for very precise, small actuated movement. In our case, we have two expansion ports for servos, SERVO0 and SERVO1. The general premise of this library is to be able to pass in a value from 0 to 180 and have the servo physically respond to said command. Let's try an example to see what that looks like: 
```py
# Rotate the motor plugged into to "SERVO 0", From 0deg to 180deg
print("Servo example:")
print("  Rotate Servo 0 CW")
i = 0
servo_number = 0
for i in range(180):
    dpiComputer.writeServo(servo_number, i)
    sleep(.05)
```
Pretty sick, right? Let's try the same, but from 180 to 0: 
```py
print("  Rotate Servo 0 CCW")
i = 0
servo_number = 0
for i in range(180,0,-1):
    dpiComputer.writeServo(servo_number, i)
    sleep(.05)
```
This works for the other servo as well. Let's try it out!
```py
# Rotate the motor plugged into to "SERVO 1", From 0deg to 180deg
#
print("  Rotate Servo 1 CW")
i = 0
servo_number = 1
for i in range(180):
    dpiComputer.writeServo(servo_number, i)
    sleep(.05)
```

It's also relevant to discuss the Talon motor controller. The controller takes in the PWM signal of a servo, and converts it to a power input to a DC motor. 0 and 180 are at full power, while 90 is at no power. This will be useful as you tackle the Kivy UI, as described below.


If you have any questions about the library and these functions, either ask an instructor, fellow student, or check out the code defining the DPi libraries. 

## Kivy UI 
Once again, it's time to create a Kivy UI. You can use your prior UIs as a starting place, just remember to create a backup of them before changing them. 

1. Connect a servo motor to SERVO 0 and make it go from 0 degrees to 180 degrees as two binary states. Be mindful that the direction you connect the servo to the DPi matter. Make sure the black wire is connected to GND.

1a. Connect a limit switch to IN 0 and make servo on SERVO 0 be at 0deg when limit switch is pressed (closed) and 180deg when open

2. Connect a Talon motor controller to SERVO 0. Turn on a DC motor at full speed clockwise. Power Talon motor controller with step down power supply. Stop 5 seconds, then send it full speed counterclockwise. Below is a close up of the Talon motor controller and an image of how the parts should be connected. Be warned, these are both fragile and pricey, so be careful!

2a. Make DC motor connected to Talon ramp up from 0rpm to full speed over 20 seconds in equal intervals.

2b. Connect a limit switch to IN 0 and make DC motor connected to talon on SERVO 0 be at full speed clockwise when limit switch is pressed(closed) and stopped when open

INSERT IMAGES HERE 

Shown below are a couple photos of the hardware in a correct setup. Try and emulate this!

