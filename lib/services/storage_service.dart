import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_profile.dart';
import 'encrypted_hive_service.dart';

class StorageService {
  static const String userProfileBox = 'user_profile_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserProfileAdapter());
    await EncryptedHiveService.openEncryptedBox<UserProfile>(userProfileBox);
  }

  static Future<void> saveUserProfile(UserProfile profile) async {
    final box = await EncryptedHiveService.openEncryptedBox<UserProfile>(userProfileBox);
    await box.put('profile', profile);
  }

  static Future<UserProfile?> loadUserProfile() async {
    final box = await EncryptedHiveService.openEncryptedBox<UserProfile>(userProfileBox);
    return box.get('profile');
  }
} 