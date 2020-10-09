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

  Box<Habit> _box;

  Future<void> initDatabase() async {
    await Hive.initFlutter();
  }

  void close() async {
    await _box.compact();
    Hive.close();
  }

  Future<void> openHabitsBox() async {
    print("openHabitBox() called");
    Hive.registerAdapter<Status>(StatusAdapter());
    Hive.registerAdapter<Habit>(HabitAdapter());
    _box = await Hive.openBox<Habit>(_HABITS_BOX);
  }

  Future<int> insertHabit(Habit habit) async => _box.add(habit);

  Future<void> updateHabit(int index, Habit habit) => _box.putAt(index, habit);

  Future<void> deleteHabit(int id) => _box.deleteAt(id);

  Future<List<Habit>> getHabits() async {
    if (_box == null) await Hive.openBox<Habit>(_HABITS_BOX);
    return _box.values.toList().cast<Habit>();
  }
}
