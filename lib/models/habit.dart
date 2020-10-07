import 'package:flutter/cupertino.dart';

class Habit {
  int id;
  String name;
  Status status;
  String imageUrl;
  int days;
  int notificationTime;

  Habit({
    this.id = 0,
    @required this.name,
    this.status = Status.ACTIVE,
    @required this.imageUrl,
    this.days = 0,
    this.notificationTime = -1,
  });

  factory Habit.fromMap(Map<String, dynamic> map) {
    return new Habit(
      id: map['id'] as int,
      name: map['name'] as String,
      status: Status.values[map['status'] as int],
      imageUrl: map['imageUrl'] as String,
      days: map['days'] as int,
      notificationTime: map['notificationTime'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'status': this.status.index,
      'imageUrl': this.imageUrl,
      'days': this.days,
      'notificationTime': this.notificationTime,
    };
  }

  Habit copyWith({
    int id,
    String name,
    Status status,
    String imageUrl,
    int days,
    int notificationTime,
  }) {
    return new Habit(
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
    return 'Habit{id: $id, name: $name, status: $status, imageUrl: $imageUrl , days: $days, notificationTime: $notificationTime}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
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
}

enum Status { ACTIVE, COMPLETED, EXPIRED }
