part of 'home_cubit.dart';


@immutable
abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeFilled extends HomeState {
  final List<Habit> habitsList;

  const HomeFilled({
    @required this.habitsList,
  });

  HomeFilled copyWith({
    List<Habit> habitsList,
  }) {
    if ((habitsList == null || identical(habitsList, this.habitsList))) {
      return this;
    }

    return new HomeFilled(
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
          (other is HomeFilled &&
              runtimeType == other.runtimeType &&
              habitsList == other.habitsList);

  @override
  int get hashCode => habitsList.hashCode;
}
