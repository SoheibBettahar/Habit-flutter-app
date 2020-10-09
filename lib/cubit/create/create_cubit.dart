import 'package:bloc/bloc.dart';
import 'package:habit/models/habit.dart';
import 'package:habit/repository/repository.dart';
import 'package:meta/meta.dart';

part 'create_state.dart';

class CreateCubit extends Cubit<CreateState> {
  final Repository _repository = Repository.instance;
  CreateCubit() : super(CreateInitial());

  void create(Habit habit) async {
    await _repository.insertHabit(habit);
    emit(CreateFinished());
  }
}
