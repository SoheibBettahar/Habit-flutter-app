# Habit
An app that lets you create letters, lock them in a vault so that you can read them in the future.
In this document I'm going to break down the overall structure of the app.

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





