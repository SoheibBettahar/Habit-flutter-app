import 'package:flutter/cupertino.dart';
import 'package:habit/models/status.dart';

import 'habit.dart';

class DomainHabit {
  int id;
  String name;
  Status status;
  String imageUrl;
  int days = 0;
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

  Habit toHabit() => Habit(
      name: this.name,
      status: this.status,
      imageUrl: this.imageUrl,
      days: this.days,
      notificationTime: this.notificationTime);

  DomainHabit({
    @required this.id,
    @required this.name,
    @required this.status,
    @required this.imageUrl,
    @required this.days,
    @required this.notificationTime,
  });

  DomainHabit copyWith({
    int id,
    String name,
    Status status,
    String imageUrl,
    int days,
    int notificationTime,
  }) {
    return new DomainHabit(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      days: days ?? this.days,
      notificationTime: notificationTime ?? this.notificationTime,
    );
  }

  @override
  String toString() {
    return 'DomainHabit{id: $id, name: $name, status: $status, imageUrl: $imageUrl, days: $days, notificationTime: $notificationTime}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DomainHabit &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          status == other.status &&
          imageUrl == other.imageUrl &&
          days == other.days &&
          notificationTime == other.notificationTime);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      status.hashCode ^
      imageUrl.hashCode ^
      days.hashCode ^
      notificationTime.hashCode;

  factory DomainHabit.fromMap(Map<String, dynamic> map) {
    return new DomainHabit(
      id: map['id'] as int,
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
      'id': this.id,
      'name': this.name,
      'status': this.status,
      'imageUrl': this.imageUrl,
      'days': this.days,
      'notificationTime': this.notificationTime,
    } as Map<String, dynamic>;
  }
}
