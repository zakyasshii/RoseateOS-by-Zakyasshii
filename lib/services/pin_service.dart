import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PinService {
  static const _pinKey = 'user_pin';
  static const _pinEnabledKey = 'pin_enabled';
  static final _storage = const FlutterSecureStorage();

  static Future<void> setPin(String pin) async {
    await _storage.write(key: _pinKey, value: pin);
    await setPinEnabled(true);
  }

  static Future<String?> getPin() async {
    return await _storage.read(key: _pinKey);
  }

  static Future<void> removePin() async {
    await _storage.delete(key: _pinKey);
    await setPinEnabled(false);
  }

  static Future<void> setPinEnabled(bool enabled) async {
    await _storage.write(key: _pinEnabledKey, value: enabled ? 'true' : 'false');
  }

  static Future<bool> isPinEnabled() async {
    final value = await _storage.read(key: _pinEnabledKey);
    return value == 'true';
  }

  static Future<bool> checkPin(String pin) async {
    final storedPin = await getPin();
    return storedPin == pin;
  }
} 