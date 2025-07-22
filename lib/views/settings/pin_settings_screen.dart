import 'package:flutter/material.dart';
import '../../services/pin_service.dart';

class PinSettingsScreen extends StatefulWidget {
  const PinSettingsScreen({super.key});

  @override
  State<PinSettingsScreen> createState() => _PinSettingsScreenState();
}

class _PinSettingsScreenState extends State<PinSettingsScreen> {
  bool _pinEnabled = false;
  final _pinController = TextEditingController();
  final _confirmController = TextEditingController();
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPinStatus();
  }

  Future<void> _loadPinStatus() async {
    final enabled = await PinService.isPinEnabled();
    setState(() {
      _pinEnabled = enabled;
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
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PIN set successfully')));
  }

  Future<void> _disablePin() async {
    await PinService.removePin();
    setState(() {
      _pinEnabled = false;
      _pinController.clear();
      _confirmController.clear();
      _error = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PIN disabled')));
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
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
              onChanged: (val) async {
                if (val) {
                  // Enable PIN
                } else {
                  await _disablePin();
                }
              },
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
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _disablePin,
                child: const Text('Disable PIN'),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 