import 'package:habit/database/habit_database.dart';
import 'package:habit/models/domain_habit.dart';
import 'package:habit/models/habit.dart';
import 'package:habit/utils/utils.dart';

class Repository {
  Repository._();

  static Repository _instance;

  static Repository get instance {
    if (_instance == null) _instance = Repository._();
    return _instance;
  }

  Future<List<DomainHabit>> getHabits() async {
    List<Habit> habits = await HabitDatabase.getHabits();
    List<int> keys = await HabitDatabase.getKeys();

    return toDomainList(keys, habits);
  }

  Future<int> insertHabit(Habit habit) async {
    var id = await HabitDatabase.insertHabit(habit);
    return id;
  }

  Future<void> updateHabit(int id, DomainHabit domain) =>
      HabitDatabase.updateHabit(id, domain.toHabit());

  Future<void> deleteByIndex(int index) async {
    await HabitDatabase.deleteAt(index);
  }

  Future<void> delete(int id) async {
    await HabitDatabase.delete(id);
  }
}
