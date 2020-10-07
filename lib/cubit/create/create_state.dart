part of 'create_cubit.dart';

@immutable
abstract class CreateState {
  const CreateState();
}

class CreateInitial extends CreateState {
  const CreateInitial();
}

class CreateFinished extends CreateState {
  const CreateFinished();
}
