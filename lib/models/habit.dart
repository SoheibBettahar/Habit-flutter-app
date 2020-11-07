import 'package:flutter/cupertino.dart';
import 'package:habit/models/domain_habit.dart';
import 'package:habit/models/status.dart';
import 'package:hive/hive.dart';

part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit {
  @HiveField(0)
  String name;
  @HiveField(1)
  Status status;
  @HiveField(2)
  String imageUrl;
  @HiveField(3)
  int days;
  @HiveField(4)
  int notificationTime;

  String get getStatus {
    switch (status) {
      case Status.ACTIVE:
        return "Active";
      case Status.COMPLETED:
        return "Completed";
      default:
        return "Expired";
    }
  }

  static Status fromStatus(String statusString) {
    switch (statusString) {
      case "Active":
        return Status.ACTIVE;
      case "Completed":
        return Status.COMPLETED;
      default:
        return Status.EXPIRED;
    }
  }

  DomainHabit toDomainHabit(int id) => DomainHabit(
      id: id,
      name: this.name,
      status: this.status,
      imageUrl: this.imageUrl,
      days: this.days,
      notificationTime: this.notificationTime);

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  Habit({
    @required this.name,
    this.status = Status.ACTIVE,
    @required this.imageUrl,
    this.days = 0,
    @required this.notificationTime,
  });

  Habit copyWith({
    String name,
    Status status,
    String imageUrl,
    int days,
    int notificationTime,
  }) {
    return new Habit(
      name: name ?? this.name,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      days: days ?? this.days,
      notificationTime: notificationTime ?? this.notificationTime,
    );
  }

  @override
  String toString() {
    return 'Habit{name: $name, status: $status, imageUrl: $imageUrl, days: $days, notificationTime: $notificationTime}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          status == other.status &&
          imageUrl == other.imageUrl &&
          days == other.days &&
          notificationTime == other.notificationTime);

  @override
  int get hashCode =>
      name.hashCode ^
      status.hashCode ^
      imageUrl.hashCode ^
      days.hashCode ^
      notificationTime.hashCode;

  factory Habit.fromMap(Map<String, dynamic> map) {
    return new Habit(
      name: map['name'] as String,
      status: map['status'] as Status,
      imageUrl: map['imageUrl'] as String,
      days: map['days'] as int,
      notificationTime: map['notificationTime'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'name': this.name,
      'status': this.status,
      'imageUrl': this.imageUrl,
      'days': this.days,
      'notificationTime': this.notificationTime,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
