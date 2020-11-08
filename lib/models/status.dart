import 'package:hive/hive.dart';

part 'status.g.dart';

@HiveType(typeId: 1)
enum Status {
  @HiveField(0)
  ACTIVE,

  @HiveField(1)
  COMPLETED,

  @HiveField(2)
  EXPIRED
}
