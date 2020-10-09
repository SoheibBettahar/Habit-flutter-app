part of 'home_cubit.dart';


@immutable
abstract class HomeState {
  const HomeState();
}
class HomeEmpty extends HomeState {
  const HomeEmpty();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<Habit> habitsList;

  const HomeLoaded({
    @required this.habitsList,
  });

  HomeLoaded copyWith({
    List<Habit> habitsList,
  }) {
    if ((habitsList == null || identical(habitsList, this.habitsList))) {
      return this;
    }

    return new HomeLoaded(
      habitsList: habitsList ?? this.habitsList,
    );
  }

  @override
  String toString() {
    return 'HomeFilled{habitsList: $habitsList}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is HomeLoaded &&
              runtimeType == other.runtimeType &&
              habitsList == other.habitsList);

  @override
  int get hashCode => habitsList.hashCode;
}
