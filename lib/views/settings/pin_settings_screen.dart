import 'package:flutter/material.dart';
import '../../services/biometric_auth_service.dart';
import '../../services/pin_service.dart';

class PinSettingsScreen extends StatefulWidget {
  const PinSettingsScreen({super.key});

  @override
  State<PinSettingsScreen> createState() => _PinSettingsScreenState();
}

class _PinSettingsScreenState extends State<PinSettingsScreen> {
  bool _pinEnabled = false;
  bool _biometricEnabled = false;
  bool _biometricAvailable = false;
  final _pinController = TextEditingController();
  final _confirmController = TextEditingController();
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final pinEnabled = await PinService.isPinEnabled();
    final biometricEnabled = await PinService.isBiometricEnabled();
    final biometricAvailable = await BiometricAuthService.isDeviceSupported();
    setState(() {
      _pinEnabled = pinEnabled;
      _biometricEnabled = biometricEnabled;
      _biometricAvailable = biometricAvailable;
      _loading = false;
    });
  }

  Future<void> _savePin() async {
    final pin = _pinController.text;
    final confirm = _confirmController.text;
    if (pin.length != 6 || confirm.length != 6) {
      setState(() => _error = 'PIN must be 6 digits');
      return;
    }
    if (pin != confirm) {
      setState(() => _error = 'PINs do not match');
      return;
    }
    await PinService.setPin(pin);
    setState(() {
      _pinEnabled = true;
      _error = null;
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('PIN set successfully')),
    );
  }

  Future<void> _disablePin() async {
    await PinService.removePin();
    setState(() {
      _pinEnabled = false;
      _biometricEnabled = false;
      _pinController.clear();
      _confirmController.clear();
      _error = null;
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('PIN disabled')),
    );
  }

  Future<void> _setBiometric(bool enabled) async {
    if (enabled) {
      final success = await BiometricAuthService.authenticate();
      if (!success) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Biometric verification failed')),
        );
        return;
      }
    }
    await PinService.setBiometricEnabled(enabled);
    setState(() => _biometricEnabled = enabled);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          enabled ? 'Fingerprint unlock enabled' : 'Fingerprint unlock disabled',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('PIN Lock Settings')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              value: _pinEnabled,
              title: const Text('Enable PIN Lock'),
              subtitle: const Text('Set a 6-digit PIN below to protect the app'),
              onChanged: _pinEnabled
                  ? (val) async {
                      if (!val) {
                        await _disablePin();
                      }
                    }
                  : null,
            ),
            if (!_pinEnabled) ...[
              TextField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 6,
                decoration: const InputDecoration(labelText: 'Enter 6-digit PIN'),
              ),
              TextField(
                controller: _confirmController,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 6,
                decoration: const InputDecoration(labelText: 'Confirm PIN'),
              ),
              if (_error != null) ...[
                const SizedBox(height: 8),
                Text(_error!, style: const TextStyle(color: Colors.red)),
              ],
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _savePin,
                child: const Text('Set PIN'),
              ),
            ],
            if (_pinEnabled) ...[
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _disablePin,
                child: const Text('Disable PIN'),
              ),
              const Divider(height: 32),
              SwitchListTile(
                value: _biometricEnabled,
                title: const Text('Fingerprint unlock'),
                subtitle: Text(
                  _biometricAvailable
                      ? 'Unlock with fingerprint on the lock screen'
                      : 'Biometrics are not available on this device',
                ),
                onChanged: _biometricAvailable
                    ? (val) => _setBiometric(val)
                    : null,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
