import 'package:hive/hive.dart';
import '../models/note.dart';
import '../services/encrypted_hive_service.dart';

class NoteController {
  static const String noteBoxName = 'notes_box';

  Future<void> addNote(Note note) async {
    final box = await EncryptedHiveService.openEncryptedBox<Note>(noteBoxName);
    await box.add(note);
  }

  Future<List<Note>> getNotes() async {
    final box = await EncryptedHiveService.openEncryptedBox<Note>(noteBoxName);
    return box.values.toList();
  }

  Future<void> updateNote(int key, Note updatedNote) async {
    final box = await EncryptedHiveService.openEncryptedBox<Note>(noteBoxName);
    await box.put(key, updatedNote);
  }

  Future<void> deleteNote(int key) async {
    final box = await EncryptedHiveService.openEncryptedBox<Note>(noteBoxName);
    await box.delete(key);
  }
} 