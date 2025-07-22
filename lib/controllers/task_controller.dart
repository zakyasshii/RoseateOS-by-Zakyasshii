import 'package:hive/hive.dart';
import '../models/task.dart';
import '../services/encrypted_hive_service.dart';

class TaskController {
  static const String taskBoxName = 'tasks_box';

  Future<void> addTask(Task task) async {
    final box = await EncryptedHiveService.openEncryptedBox<Task>(taskBoxName);
    await box.add(task);
  }

  Future<List<Task>> getTasks() async {
    final box = await EncryptedHiveService.openEncryptedBox<Task>(taskBoxName);
    return box.values.toList();
  }

  Future<void> updateTask(int key, Task updatedTask) async {
    final box = await EncryptedHiveService.openEncryptedBox<Task>(taskBoxName);
    await box.put(key, updatedTask);
  }

  Future<void> deleteTask(int key) async {
    final box = await EncryptedHiveService.openEncryptedBox<Task>(taskBoxName);
    await box.delete(key);
  }
} 