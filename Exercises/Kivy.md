---
title: Kivy
layout: default
---

# Kivy 

You now know how to make things in python! How, though, are we going to display that to the end user?

At the Engineering Academy, we use the library Kivy for user interfaces (UIs). These are hosted on touch screen tablets connected to Rasberry Pis, which are tiny processors running a stripped down version of Linux. What this means is that anything that runs on your computer and accessible through the mouse and keyboard should be directly transferrable to the Raspberry Pis, so you can test out all of your ideas on a local machine and just send it over when your project is all done and ready! Dope.

(include some information on installing pycharm here)


# The Basics
Personally, I'm not a fan of video tutorials. If that's your jam, however, there's two options available to you: this page, or [these tutorials by Tech with Tim]: go up to the sixth video. Be sure to follow along by actually typing down and creating whatever Tech with Tim is in his videos, as it's super helpful for developing an intuition of how to solve problems with the interface and provides some familiarity with the development of your UIs. 

Note that these guides do contain slightly different pieces of information. This text guide should be a little bit more tailor made to the specific flavor of Kivy that we use in the DPEA, though you'll definitely be able to piece together how many of the DPEA utilities work with some trial and error. 


## Imports

Create a file named main.py. The easiest way to do so is to right click your project folder name -> new -> define a new python file.

Let's begin by importing some utilities.

```py
import kivy
from kivy.app import App
from kivy.uix.label import Label
```

## Body

Let's now create the main class that defines our application. This class _inherits_ from the _App class_, which is what we imported above in our utilities. This means that a lot of the boilerplate in the basic functions of the app are already filled in for you by Kivy themselves.
Pretty sweet!

We also have a build functions bound to our MyApp class that takes in a Label widget [what we imported above], and passes in a textual parameter. We also specify that, if you're running this file directly, to display the application in question to the user using the _run_ method. 

Where does the run function come from? Where is the init function for this class? All of this is done implicitly through inheritance, as by default the superclass constructor is called and superclass methods are accessible through good old dot notation. 
```py
class main(App):

    def build(self):
        return Label(text = "put your name in here!")

if __name__ == "__main__":
    main().run()
```

Paste this in and check out what happens. You should also be able to dynamically resize your window, one of the great features of the App class we inherited from. 

We don't technically have to include the _if main_ conditional, but it's just good pythonic practice as to not run things where you don't want to. 
{: .note }

## Relevant Information

Just a brief note on the design principle of the Kivy language. Everything is centered around the idea of widgets: which, similar to objects, encapsulate design elements into a descrete package. It gets a little bit complicated, as you'll end up nesting many of these widgets together: for instance, a button is a Widget, but a Layout, used to space out buttons, is also a Widget, as well as the screen that ecompasses all elements on the canvas. This widget-ception definitely takes some time to wrap your head around, but it'll hopefully make more sense as we continue onto more tangible examples. 

There's also one more thing to discuss -- the seperation of programmatic and design elements. Kivy is very explicit in not wanting these two elements to intermingle, providing very few options to allow users to perofrm both of these tasks in the same file. In fact, kivy makes this so explicit that you're essentially required to use a _seperate design language_ in _.kv_ files in order to structure and place all of your elements down onto a canvas. 

## First .kv file
Alright, let's start off with your first .kv file. The restrictions on the naming convention of your file are:

1. It must be all lowercase
3. If your "build" class ends in app, you can't include it in your file name. (the easy way to avoid this restriction is just to not name the class doing the building with app.)
4. It must end with .kv
5. It must be stored in the same directory as your python file 

For our filename, we'll call it _main.kv_. Create it using the same process as your _main.py_ file, but with the general file creation command rather than the one specifically for Python files. 

# Your Python File

We'll need to import the button class to be able to import it. However, we'll be using a modified version of the button class, the DPEAButton, which offers a suite of features that make it execptionally useful for seamless placement and integration of buttons into your UI. 
```py
from pidev.kivy import DPEAButton
```

We'll also need some other utilities for the screen, connecting the .kv and .py files, and changing the color of your window. 

```py
from kivy.uix.screenmanager import ScreenManager, Screen
from kivy.lang import Builder
from kivy.core.window import Window
```

## Screens

Remember that widget model I discussed earlier? It's pertinent now, because we'll be using Screens to add elements to our canvas. We often have multiple screens, with interactions between them: to manage those, let's use the ScreenManager class.

Define a screen manager objcet called ScreenManager. 

```py
SCREEN_MANAGER = ScreenManager()
```
Let's also define a variable that represents the name of your main screen. This isn't explicitly necessary, but is good practice for when you have to manage multiple screens without any ambiguity as to which screen is which. 

```py
MAIN_SCREEN_NAME = 'main
```

## Your First Screen 

Let's also define a new screen, below your main class To do so, we'll need a new class -- in our case, mainScreen -- and we'll need to inherit from the Screen class we recently imported. Note that, just like all Kivy classes, this is a normal python class, and there's no strange chicanery that prevents you from doing normal python stuff. To prove this, let's also define a function in the class, _kermit_, that just prints out our unconditional love of Kermit the Frog. 

```py
class mainScreen(Screen):
    def kermit(self):
        print("I love Kermit the Frog")
```

## The .kv File

We'll be hopping around a little bit here, but navigate to your empty .kv file. We'll now be defining the widgets that'll populate our main screen within your .kv file. .kv files have their own unique syntax, but the indentation system is exactly the same as in python.  Let's define the mainScreen as our root file [and be able to reference it as such] through a "class rule definition" at the start of your file. We'll also need to specify a name attribute for the screen in order to bind it to our Python file using the builder. 

We also need to define our screen as a layout. We'll be using a FloatLayout [as we will for the majority of our projects in the EA], as they allow for essentially unbounded flexibility in operation. 

We'll also need to define a "size_hint attribute" in order to tell Kivy the scale of our layout. size_hint is an attribute for ALL widgets, and in its typical form defines the size of a widget in terms of the length of the overarching widget in decimals of x and y. For instance, defining size_hint as "size_hint: 0.9, 0.1" would be mean that we create a widget 0.9 times the width of the overarching structure, and 0.1 times the length of the overarching structure. There also is a similar attribute, pos_hint, that acts in the same way and is applicable to all widgets. 

This, however, is honestly sort of inconvienient. To use absolute positions, and define the size and position of object in terms of tangible coordinates, we can use a shortcut and set the size_hint of our layout as "None, Nonpressede." This is what all of these steps look like combined together: 


```py 
<mainScreen>:
    name: 'main'
    FloatLayout:
        size_hint: None, None
```

That's a lot of information for not a lot of text! 

## The Button!

We finally have the bones to be able to create our button! First, let's define our DPEAButton: 

```py
<mainScreen>:
    name: 'main'
    FloatLayout:
        size_hint: None, None
    DPEAButton:
    ```
We now need to give the DPEAButton attributes that identify it. All of the [general button attributes] should work, but the ones we'll cover are the most useful.
















## Connecting the two together

It's now time to connect our future .kv interface to our python file. We'll be using the builder class that we imported earlier to do so:

```py
Builder.load_file('main.kv')
```





[these tutorials by Tech with Tim]: https://www.youtube.com/watch?v=bMHK6NDVlCM&list=PLzMcBGfZo4-kSJVMyYeOQ8CXJ3z1k7gHn


