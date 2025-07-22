import 'package:hive/hive.dart';
part 'goal.g.dart';

@HiveType(typeId: 2)
class Goal extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double progress; // 0.0 to 1.0

  @HiveField(2)
  DateTime? targetDate;

  Goal({required this.name, this.progress = 0.0, this.targetDate});
} 