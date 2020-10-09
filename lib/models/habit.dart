import 'package:flutter/cupertino.dart';
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

  Habit({
    @required this.name,
    this.status = Status.ACTIVE,
    @required this.imageUrl,
    this.days = 0,
    this.notificationTime = -1,
  });
}
