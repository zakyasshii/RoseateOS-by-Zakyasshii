import '../models/user_profile.dart';
import '../services/storage_service.dart';

class FirstLaunchController {
  Future<void> saveProfile(String name, int age) async {
    final profile = UserProfile(name: name, age: age);
    await StorageService.saveUserProfile(profile);
  }

  UserProfile? getProfile() {
    return StorageService.loadUserProfile();
  }
} 