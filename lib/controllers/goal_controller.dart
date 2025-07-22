import 'package:hive/hive.dart';
import '../models/goal.dart';
import '../services/encrypted_hive_service.dart';

class GoalController {
  static const String goalBoxName = 'goals_box';

  Future<void> addGoal(Goal goal) async {
    final box = await EncryptedHiveService.openEncryptedBox<Goal>(goalBoxName);
    await box.add(goal);
  }

  Future<List<Goal>> getGoals() async {
    final box = await EncryptedHiveService.openEncryptedBox<Goal>(goalBoxName);
    return box.values.toList();
  }

  Future<void> updateGoal(int key, Goal updatedGoal) async {
    final box = await EncryptedHiveService.openEncryptedBox<Goal>(goalBoxName);
    await box.put(key, updatedGoal);
  }

  Future<void> deleteGoal(int key) async {
    final box = await EncryptedHiveService.openEncryptedBox<Goal>(goalBoxName);
    await box.delete(key);
  }
} 