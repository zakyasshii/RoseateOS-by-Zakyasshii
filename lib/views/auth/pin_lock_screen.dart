import 'package:flutter/material.dart';

class PinLockScreen extends StatefulWidget {
  final Future<bool> Function(String) onValidate;
  final VoidCallback onSuccess;
  const PinLockScreen({super.key, required this.onValidate, required this.onSuccess});

  @override
  State<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends State<PinLockScreen> {
  final _controller = TextEditingController();
  String? _error;
  bool _loading = false;

  void _submit() async {
    setState(() { _loading = true; _error = null; });
    final pin = _controller.text;
    if (pin.length != 6) {
      setState(() { _error = 'Enter a 6-digit PIN'; _loading = false; });
      return;
    }
    final valid = await widget.onValidate(pin);
    if (valid) {
      widget.onSuccess();
    } else {
      setState(() { _error = 'Incorrect PIN'; _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter PIN')),
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
          ],
        ),
      ),
    );
  }
} 