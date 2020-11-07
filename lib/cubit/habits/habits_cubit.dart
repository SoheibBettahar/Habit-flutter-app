import 'package:bloc/bloc.dart';
import 'package:habit/models/domain_habit.dart';
import 'package:habit/models/habit.dart';
import 'package:habit/repository/repository.dart';
import 'package:meta/meta.dart';

part 'habits_state.dart';

class HabitsCubit extends Cubit<HabitsState> {
  final Repository _repository;

  HabitsCubit(this._repository) : super(HabitsLoading());

  Future<void> getAll() async {
    List<DomainHabit> habits = await _repository.getHabits();
    if (habits.isNotEmpty) {
      emit(HabitsLoaded(habitsList: habits));
    } else {
      emit(HabitsEmpty());
    }
  }

  Future<int> create(Habit habit) async {
    int id = await _repository.insertHabit(habit);
    List<DomainHabit> habits = await _repository.getHabits();
    emit(HabitsLoaded(habitsList: habits));
    return id;
  }

  Future<void> deleteByIndex(int index) async {
    await _repository.deleteByIndex(index);
    List<DomainHabit> habits = await _repository.getHabits();
    if (habits.isNotEmpty)
      emit(HabitsLoaded(habitsList: habits));
    else
      emit(HabitsEmpty());
  }

  Future<void> delete(int id) async {
    await _repository.delete(id);
    List<DomainHabit> habits = await _repository.getHabits();
    if (habits.isNotEmpty)
      emit(HabitsLoaded(habitsList: habits));
    else
      emit(HabitsEmpty());
  }

  Future<void> update(int id, DomainHabit habit) async {
    await _repository.updateHabit(id, habit);
    List<DomainHabit> habits = await _repository.getHabits();
    emit(HabitsLoaded(habitsList: habits));
  }

  DomainHabit getHabit(int id) {
    return (state as HabitsLoaded)
        .habitsList
        .where((habit) => habit.id == id)
        .first;
  }
}
