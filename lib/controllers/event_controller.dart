import 'package:hive/hive.dart';
import '../models/event.dart';
import '../services/encrypted_hive_service.dart';

class EventController {
  static const String eventBoxName = 'events_box';

  Future<void> addEvent(Event event) async {
    final box = await EncryptedHiveService.openEncryptedBox<Event>(eventBoxName);
    await box.add(event);
  }

  Future<List<Event>> getEvents() async {
    final box = await EncryptedHiveService.openEncryptedBox<Event>(eventBoxName);
    return box.values.toList();
  }

  Future<void> updateEvent(int key, Event updatedEvent) async {
    final box = await EncryptedHiveService.openEncryptedBox<Event>(eventBoxName);
    await box.put(key, updatedEvent);
  }

  Future<void> deleteEvent(int key) async {
    final box = await EncryptedHiveService.openEncryptedBox<Event>(eventBoxName);
    await box.delete(key);
  }
} 