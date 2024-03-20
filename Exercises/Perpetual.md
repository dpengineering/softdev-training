---
title: Perpetual Motion Machine
layout: default
nav_order: 9
---
# Perpetual Motion Machine
## Introduction
How time flies! With the skills you've developed by going through these sheets, you're ready to tackle your first project! You'll be programming the Perpetual Motion machine, which, as the name suggests, moves a ball up and down a ramp till the end of time. Or, well, until you unplug it. 

Note that we only have about 4 Perpetual motion machines (and obviously, more than 4 people in software), so you'll need to split up into groups of two or three to be able to tackle this project. Here, you'll be using your Git skills to be able to collaborate across space (and perhaps even time?) It's a learning curve for sure, so don't be worried if Git seems confusing at first!

- If the perpetual motion machine hardware is not available, let the DPEA software instructor know -- they may be able to get you working on the next project, the Robotic Arm, and then come back and finish up the project later on. 

## Git collaboration
info on git here 

This project is pretty daunting, so there's a template that's been provided for you for the Kivy UI. This has hopefully already been cloned
from https://github.com/dpengineering/Project-Examples.

## Structure 
Take note of how the project is set up! It relies on raw functions that control the hardware, which is then built up to higher-order functions that chain different aspects of hardware control together to do cool automated tasks. For instance, the function toggleGate is independent of hardware, instead calling the openGate function that takes in a parameter to address this more complex behaviour to open and close the gate. 

This is known as **abstraction**, and is a super important concept that extends through all of computer science! By focusing on hardware control first, then moving on to the greater problem of automated control, you're able to segment the problem into nicer, discrete chunks and have really pretty, clean code. It also saves time, allowing you to reuse code in a flash! Abstraction permeates everything -- databasing, computer operating systems, even Python itself is built upon abstractions after abstractions. 

Alright, so what do we need to abstract? 

In my opinion, there should be functions for the gate, staircase, ramp, the limit switch, and the two proximity sensors. 

We also want to create functions to change the ramp speed, staircase speed, and a function that automatically completes a cycle of the motion machine. 

As such, you should have the following functions in your code to control hardware: 

debounce, openGate, turnOnStaircase, moveRamp,  setRampSpeed, setStaircaseSpeed, isBallAtBottomOfRamp, isBallAtTopOfRamp 

Here's a GIF that shows the desired functionality for this project.

GIF HERE

Good luck, and don't be afraid to ask for help! 

