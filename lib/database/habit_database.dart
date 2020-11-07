import 'package:habit/models/habit.dart';
import 'package:habit/models/status.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HabitDatabase {
  static const String _HABITS_BOX = 'habits';

  HabitDatabase._();

  static HabitDatabase _instance;

  static HabitDatabase get instance {
    if (_instance == null) _instance = HabitDatabase._();
    return _instance;
  }

  static Box<Habit> _box;

  static Future<void> initDatabase() async {
    await Hive.initFlutter();
  }

  static void close() async {
    await _box.compact();
    Hive.close();
  }

  static Future<void> openHabitsBox() async {
    print("openHabitBox() called");
    Hive.registerAdapter<Status>(StatusAdapter());
    Hive.registerAdapter<Habit>(HabitAdapter());
    _box = await Hive.openBox<Habit>(_HABITS_BOX);
  }

  static Future<int> insertHabit(Habit habit) async => _box.add(habit);

  static Future<void> updateHabit(int id, Habit habit) => _box.put(id, habit);

  static Future<void> deleteAt(int index) async {
    await _box.deleteAt(index);
  }

  static Future<void> delete(int key) async {
    await _box.delete(key);
  }

  static Future<List<Habit>> getHabits() async {
    if (_box == null) await Hive.openBox<Habit>(_HABITS_BOX);
    return _box.values.toList().cast<Habit>();
  }

  static Future<List<int>> getKeys() async {
    if (_box == null) await Hive.openBox<Habit>(_HABITS_BOX);
    return _box.keys.toList().cast<int>();
  }

  // Habit getHabit(int index) {
  //   return _box.getAt(index);
  // }
}
