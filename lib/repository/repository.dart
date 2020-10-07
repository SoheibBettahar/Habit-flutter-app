import 'package:habit/database/habit_database.dart';
import 'package:habit/models/habit.dart';

class Repository {
  Future<List<Habit>> getHabits() => HabitDatabase.db.getHabits();

  Future<Habit> getHabit(int id) => HabitDatabase.db.getHabit(id);

  Future<int> insertHabit(Habit habit) async{
   var result = await HabitDatabase.db.insertHabit(habit);
    return result;
  }

  Future<int> updateHabit(Habit habit) => HabitDatabase.db.updateHabit(habit);

  Future<int> deleteHabit(int id) => HabitDatabase.db.deleteHabit(id);
}
