---
title: Steppers
layout: default
---
Now comes the fun part! We'll be running some hardware through the RPi on the DPi Computer Plus, First, watch the following videos to gain some background on some of the DPEA hardware and their various functions and operations: 

[The mechanisms behind motors]; Watch from 3 minutes to 8 minutes

[Some info about the Talons]

[The functions of a stepper]

[Servos]

Alright, it's now time to dive into the code to actually control steppers! First, clone this repository to your documents folder through a means of your choice: https://github.com/dpengineering/DPEA_DPi/tree/HarlowDevelopment/DPi_Examples.

You should also install the interactive shell version of python, ipython, for more detailed and verbose outputs. Ask a teacher for a DPi Stepper board, plug in the stepper motor into MOTOR 0, then connect DPi Stepper to the DPi Computer. Keep in mind that the orientation you plug things in does matter -- if you feel quite a bit of resistance, don't force connectors where they don't want to be! Ask a teacher or mentor for help. 

Now, go through DPiStepper_Startup.py like a tutorial -- read through it line by line, copy pasting into an ipython session as you go, and observe how that affects your stepper board. This will hopefully introduce you to the basic command set associated with the Motor.py and Stepper.py libraries. 

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
