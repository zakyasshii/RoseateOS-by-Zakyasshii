import 'package:hive/hive.dart';
part 'event.g.dart';

@HiveType(typeId: 3)
class Event extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  String? notes;

  Event({required this.title, required this.date, this.notes});
} 