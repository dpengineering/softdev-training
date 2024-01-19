---
title: Example Project
layout: default
---
# Kivy Example Project
Let's now create an example Kivy Project on your Linux Workstation! It'll employ many of the techniques that you used in the Kivy page, as well as some new tips and tricks to make your UIs both more functional and decorative.  

First: go through [this page] to take a look at how to use Kivy on the Raspberry Pis. You'll likely know some of the information describing Kivy itself, so think of it as a brief refresher. 

Now, quickly skim [this example project]. You'll be using this project in order to build your first Kivy UI independently! Let's first check to see whether you have a copy of this repository on your local system -- ideally, it should be in the path "/home/yourusername/packages/RaspberryPiCommon." If it is not, install the repository at this link: https://github.com/dpengineering/RaspberryPiCommon. 

We now need to open the project in PyCharm. Open Pycharm and select open, navigate to RaspberryPiCommon --> PiKivyProjects, click on NewProject, and press OK. 

You'll see three files appear in pycharm -- click on main.py. Now, hit the Play button on the top right of your screen to be able to see the results! You should be able to use your mouse to play around with the interface a little bit. This template is exceptionally useful, as it's the base of basically ALL of the UIs we make here at the Engineering Academy.  

There's a fun functional secret on the page! Try clicking the very bottom of the lower right hand corner of the screen, and enter the password 7266. It's a manual override contained within all of our UIs as to be able to shut projects down lest something goes wrong. 
{: .note }

## Instructions

It's time to try and take a crack at it! Try and use this example UI to complete a series of objectives.

1. Create a button that toggles text between turning a button on and off. 

2. Create another button that displays the number of times you've pressed it. 

3. Create a slider labeled "position" that, when activated, changes the text on a seperate label or position from  to 100. 

4. Create a button that is an image. Have this button transition to a new screen when pressed.





[this page]: https://github.com/dpengineering/RaspberryPiCommon/tree/master/PiKivyProjects

[this example project]: https://github.com/dpengineering/RaspberryPiCommon/tree/master/PiKivyProjects/NewProject