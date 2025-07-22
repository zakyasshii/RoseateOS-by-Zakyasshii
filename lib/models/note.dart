import 'package:hive/hive.dart';
part 'note.g.dart';

@HiveType(typeId: 4)
class Note extends HiveObject {
  @HiveField(0)
  String content;

  @HiveField(1)
  DateTime created;

  Note({required this.content, DateTime? created}) : created = created ?? DateTime.now();
} 