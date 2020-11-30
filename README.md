# Habit
An app that lets you create habits, recieve notifications about them and track your progress, to build new good habits or get rid of bad ones.

## Screens
Habit is composed of five Screens: 

![Image of Yaktocat](https://github.com/SoheibBettahar/Habit-flutter-app/blob/master/images/mocks.png)

* __SplashScreen:__ It appears when you open the app.
* __OnBoardingScreen:__ It appears when you open the app for the first time.
* __HomeScreen:__ displays a list of all the tracked habits.
* __CreateScreen:__ Allows the user to create, set time and icon of a new habit.
* __DetailScreen:__ Allows the user to track the habit and validate the daily progress.


## App Architecture
The architecture used to create this app is __BLOC__, it seperated the app into Data layer/Ui Layer resulting in a readable, robust code.



## Problem
I am scheduling periodic background work (notification that appear in the future, updating the database). The problem is the worktasks are executed only when the app is in the foreground or background. when the app is closed the tasks do not get executed. And that happen only on some low-end mobiles.


.


