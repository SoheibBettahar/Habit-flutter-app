import 'package:habit/database/habit_database.dart';
import 'package:habit/models/habit.dart';

class Repository {
  Repository._();

  static Repository _instance;

  HabitDatabase database = HabitDatabase.instance;

  static Repository get instance {
    if (_instance == null) _instance = Repository._();
    return _instance;
  }

  Future<List<Habit>> getHabits() async {
    return await database.getHabits();
  }

  Future<int> insertHabit(Habit habit) async {
    var result = await database.insertHabit(habit);
    return result;
  }

  Future<int> updateHabit(int index, Habit habit) =>
      database.updateHabit(index, habit);

  Future<int> deleteHabit(int id) => database.deleteHabit(id);
}
