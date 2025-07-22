import 'package:hive/hive.dart';
part 'reminder.g.dart';

@HiveType(typeId: 10)
class Reminder extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  DateTime dateTime;

  @HiveField(3)
  String type; // e.g., 'task', 'event', 'goal'

  @HiveField(4)
  String recurrence; // 'none', 'daily', 'weekly', 'monthly', 'custom'

  @HiveField(5)
  int? customInterval; // in days, if recurrence == 'custom'

  Reminder({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.type,
    this.recurrence = 'none',
    this.customInterval,
  });
} 