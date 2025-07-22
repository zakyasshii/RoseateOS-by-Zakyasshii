import 'package:hive/hive.dart';
part 'contact.g.dart';

@HiveType(typeId: 5)
class Contact extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String? company;

  @HiveField(2)
  String? phone;

  @HiveField(3)
  String? email;

  Contact({required this.name, this.company, this.phone, this.email});
} 