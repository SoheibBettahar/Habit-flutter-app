import 'package:bloc/bloc.dart';
import 'package:habit/models/habit.dart';
import 'package:habit/repository/repository.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final Repository _repository = Repository.instance;

  HomeCubit() : super(HomeLoading());

  Future<void> getHabits() async {
    List<Habit> habits = await _repository.getHabits();
    if (habits.isNotEmpty) {
      emit(HomeLoaded(habitsList: habits));
    } else {
      emit(HomeEmpty());
    }
  }
}
