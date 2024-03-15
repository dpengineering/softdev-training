---
title: Robotic Arm
layout: default
---

Alright, same deal, but with the robotic arm. Same with the motion machine, you'll likely need to collaborate with a partner to get this done due to limited resources. This time, I believe there are the following necessary functions: Arm up / down, arm rotation, one proxy switch to home the stepper motor, and two proximity sensors to detect the position of the ball on the towers. We can also see from looking at the main.kv template file that we wish to be able to change the rotation of the arm and the magnet on/off, and we want a function that automatically does it all for us.

If this is the case we need eleven functions that interact with the hardware. I got: 

debounce, armControl, magnetControl, auto, moveArm, pickUpBall, dropBall, setArmPosition, homeArm, isBallOnTallTower, isBallOnShortTower

Insert video of working UI

Reminder to be careful with the hardware! This one is actually sort of dangerous -- if you blast the pnuematics at your eye, it may get seriously damaged. Be careful with all of this hardware, both due to damage to it and to you. <3

Also remember to frequently commit to Github. Progess gets lost very easily, and I'm sure your partner will appreciate it. 


