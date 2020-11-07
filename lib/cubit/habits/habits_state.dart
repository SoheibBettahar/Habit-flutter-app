part of 'habits_cubit.dart';

@immutable
abstract class HabitsState {
  const HabitsState();
}

class HabitsEmpty extends HabitsState {
  const HabitsEmpty();
}

class HabitsLoading extends HabitsState {
  const HabitsLoading();
}

// class HabitLoaded extends HabitsState {
//   final Habit habit;
//
//   const HabitLoaded({
//     @required this.habit,
//   });
//
//   HabitLoaded copyWith({
//     Habit habit,
//   }) {
//     if ((habit == null || identical(habit, this.habit))) {
//       return this;
//     }
//
//     return new HabitLoaded(
//       habit: habit ?? this.habit,
//     );
//   }
//
//   @override
//   String toString() {
//     return 'HabitLoaded{habit: $habit}';
//   }
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is HabitLoaded &&
//           runtimeType == other.runtimeType &&
//           habit == other.habit);
//
//   @override
//   int get hashCode => habit.hashCode;
//
//   factory HabitLoaded.fromMap(Map<String, dynamic> map) {
//     return new HabitLoaded(
//       habit: map['habit'] as Habit,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     // ignore: unnecessary_cast
//     return {
//       'habit': this.habit,
//     } as Map<String, dynamic>;
//   }
// }

class HabitsLoaded extends HabitsState {
  final List<DomainHabit> habitsList;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const HabitsLoaded({
    @required this.habitsList,
  });

  HabitsLoaded copyWith({
    List<DomainHabit> habitsList,
  }) {
    if ((habitsList == null || identical(habitsList, this.habitsList))) {
      return this;
    }

    return new HabitsLoaded(
      habitsList: habitsList ?? this.habitsList,
    );
  }

  @override
  String toString() {
    return 'HabitsLoaded{habitsList: $habitsList}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitsLoaded &&
          runtimeType == other.runtimeType &&
          habitsList == other.habitsList);

  @override
  int get hashCode => habitsList.hashCode;

  factory HabitsLoaded.fromMap(Map<String, dynamic> map) {
    return new HabitsLoaded(
      habitsList: map['habitsList'] as List<DomainHabit>,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'habitsList': this.habitsList,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
