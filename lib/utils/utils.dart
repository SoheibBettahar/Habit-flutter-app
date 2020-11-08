import 'package:flutter/material.dart';
import 'package:habit/database/habit_database.dart';
import 'package:habit/models/domain_habit.dart';
import 'package:habit/models/habit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'constants.dart';
import 'notification_helper.dart';

Future<bool> getFirstTIme() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  bool isFirstTime = _prefs.getBool(IS_FIRST_TIME_PREF_KEY) ?? true;
  return isFirstTime;
}

Future setFirstTIme() async {
  await SharedPreferences.getInstance()
    ..setBool(IS_FIRST_TIME_PREF_KEY, false);
}

int timeOfDayToSeconds(TimeOfDay time) {
  return time == null ? null : time.hour * 3600 + time.minute * 60;
}

TimeOfDay timeOfDayFromSeconds(int timeInSeconds) {
  int hours = (timeInSeconds / 3600).floor();
  int minutes = (timeInSeconds.remainder(3600) / 60).floor();
  return timeInSeconds == null ? null : TimeOfDay(hour: hours, minute: minutes);
}

List<DomainHabit> toDomainList(List<int> keys, List<Habit> habits) {
  List<DomainHabit> domainHabits = List<DomainHabit>();

  for (int index = 0; index < habits.length; index++) {
    domainHabits.add(habits[index].toDomainHabit(keys[index]));
  }

  return domainHabits;
}

List<Habit> toHabitList(List<DomainHabit> domains) {
  return domains.map((domain) => domain.toHabit());
}

//this function adds a Zero on the left of the time unit if its width is smaller that 2
String printTime(TimeOfDay timeOfDay) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  return "${twoDigits(timeOfDay.hour)}:${twoDigits(timeOfDay.minute)} ";
}

void callbackDispatcher() {
  Workmanager.executeTask((taskName, inputData) async {
    //show the notification
    print("WorkManager task executed taskName: $taskName");
    print("inputData: $inputData");

    if (taskName == REMINDER_NOTIFICATION_TASK ||
        taskName == DAILY_UPDATE_TASK) {
      int id = inputData[ID] as int;

      await HabitDatabase.initDatabase();
      await HabitDatabase.openHabitsBox();
      Habit habit = HabitDatabase.getHabit(id);

      await NotificationHelper.initNotifications();

      if (taskName == REMINDER_NOTIFICATION_TASK) {
        await NotificationHelper.showNotification(id, habit.name,
            "Take it one day at a time, Good luck!.", habit.name);
      }

      if (taskName == DAILY_UPDATE_TASK) {
        await HabitDatabase.updateHabit(
            id, habit.copyWith(days: habit.days + 1));
      }
    }

    return Future.value(true);
  });
}

//this notification reminds the user to remind the user of the  habit
Future scheduleReminderNotificationTask(DomainHabit habit) async {
  //optimize delay time using TimeOfTheDay.now and notificationTime
  int currentTime = timeOfDayToSeconds(TimeOfDay.now());
  int notificationTime = habit.notificationTime;
  //if initialDelay
  int initialDelayInSeconds = notificationTime > currentTime
      ? notificationTime - currentTime
      : currentTime - notificationTime + Duration(days: 1).inSeconds;

  String uniqueName = "$REMINDER_NOTIFICATION_TASK: ${habit.id}";
  String tag = habit.id.toString();

  await Workmanager.initialize(callbackDispatcher);
  await Workmanager.registerPeriodicTask(uniqueName, REMINDER_NOTIFICATION_TASK,
      tag: tag,
      inputData: {
        ID: habit.id,
      },
      frequency: Duration(minutes: 15),
      initialDelay: Duration(minutes: initialDelayInSeconds),
      backoffPolicy: BackoffPolicy.exponential,
      backoffPolicyDelay: Duration(seconds: 10));
}

//daily progress task
Future scheduleDailyUpdateTask(DomainHabit habit) async {
  String uniqueName = "$DAILY_UPDATE_TASK: ${habit.id}";
  String tag = habit.id.toString();

  await Workmanager.initialize(callbackDispatcher);
  await Workmanager.registerPeriodicTask(uniqueName, DAILY_UPDATE_TASK,
      tag: tag,
      inputData: {
        ID: habit.id,
      },
      frequency: Duration(minutes: 15),
      initialDelay: Duration(minutes: 15),
      backoffPolicy: BackoffPolicy.exponential,
      backoffPolicyDelay: Duration(seconds: 10));
}

Future cancelNotificationTask(int id) async {
  await Workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  await Workmanager.cancelByTag(id.toString());
}
