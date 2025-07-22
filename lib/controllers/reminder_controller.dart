import 'package:hive/hive.dart';
import '../models/reminder.dart';
import '../services/encrypted_hive_service.dart';

class ReminderController {
  static const String reminderBoxName = 'reminders_box';

  Future<void> addReminder(Reminder reminder) async {
    final box = await EncryptedHiveService.openEncryptedBox<Reminder>(reminderBoxName);
    await box.put(reminder.id, reminder);
  }

  Future<List<Reminder>> getReminders() async {
    final box = await EncryptedHiveService.openEncryptedBox<Reminder>(reminderBoxName);
    return box.values.toList();
  }

  Future<void> updateReminder(int id, Reminder updatedReminder) async {
    final box = await EncryptedHiveService.openEncryptedBox<Reminder>(reminderBoxName);
    await box.put(id, updatedReminder);
  }

  Future<void> deleteReminder(int id) async {
    final box = await EncryptedHiveService.openEncryptedBox<Reminder>(reminderBoxName);
    await box.delete(id);
  }
} 