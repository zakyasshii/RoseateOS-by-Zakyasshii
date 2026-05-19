import 'package:flutter/material.dart';
import '../../services/biometric_auth_service.dart';
import '../../services/pin_service.dart';

class PinLockScreen extends StatefulWidget {
  final Future<bool> Function(String) onValidate;
  final VoidCallback onSuccess;

  const PinLockScreen({
    super.key,
    required this.onValidate,
    required this.onSuccess,
  });

  @override
  State<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends State<PinLockScreen> {
  final _controller = TextEditingController();
  String? _error;
  bool _loading = false;
  bool _biometricEnabled = false;
  bool _biometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _loadBiometricState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadBiometricState() async {
    final enabled = await PinService.isBiometricEnabled();
    final available = await BiometricAuthService.isDeviceSupported();
    if (!mounted) return;
    setState(() {
      _biometricEnabled = enabled;
      _biometricAvailable = available;
    });
    if (enabled && available) {
      await _unlockWithBiometric(auto: true);
    }
  }

  Future<void> _unlockWithBiometric({bool auto = false}) async {
    if (!_biometricEnabled || !_biometricAvailable) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    final success = await BiometricAuthService.authenticate();
    if (!mounted) return;
    if (success) {
      widget.onSuccess();
    } else if (!auto) {
      setState(() {
        _error = 'Biometric authentication failed';
        _loading = false;
      });
    } else {
      setState(() => _loading = false);
    }
  }

  void _submit() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final pin = _controller.text;
    if (pin.length != 6) {
      setState(() {
        _error = 'Enter a 6-digit PIN';
        _loading = false;
      });
      return;
    }
    final valid = await widget.onValidate(pin);
    if (!mounted) return;
    if (valid) {
      widget.onSuccess();
    } else {
      setState(() {
        _error = 'Incorrect PIN';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final showBiometricButton = _biometricEnabled && _biometricAvailable;

    return Scaffold(
      appBar: AppBar(title: const Text('Unlock RoseateOS')),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Enter your 6-digit PIN to unlock'),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 6,
              decoration: InputDecoration(
                errorText: _error,
                counterText: '',
              ),
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 16),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Unlock'),
                  ),
            if (showBiometricButton) ...[
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: _loading ? null : () => _unlockWithBiometric(),
                icon: const Icon(Icons.fingerprint),
                label: const Text('Use fingerprint'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
