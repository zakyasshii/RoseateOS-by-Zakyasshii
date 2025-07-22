import 'package:flutter/material.dart';
import '../../controllers/first_launch_controller.dart';
import '../../services/storage_service.dart';

class FirstLaunchScreen extends StatefulWidget {
  const FirstLaunchScreen({super.key});

  @override
  State<FirstLaunchScreen> createState() => _FirstLaunchScreenState();
}

class _FirstLaunchScreenState extends State<FirstLaunchScreen> {
  bool _agreedToTerms = false;
  final _formKey = GlobalKey<FormState>();
  String? _name;
  int? _age;
  final _controller = FirstLaunchController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    StorageService.init();
  }

  void _onContinue() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      setState(() => _saving = true);
      await _controller.saveProfile(_name!, _age!);
      setState(() => _saving = false);
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainMenuScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome to RoseateOS')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Terms & Conditions', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'Please read and accept the Terms & Conditions to continue. (Full T&C will be loaded here.)',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: _agreedToTerms,
                  onChanged: (val) => setState(() => _agreedToTerms = val ?? false),
                ),
                const Text('I agree to the Terms & Conditions'),
              ],
            ),
            if (_agreedToTerms) ...[
              const Divider(),
              const Text('Profile Setup', style: TextStyle(fontWeight: FontWeight.bold)),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (val) => val == null || val.isEmpty ? 'Enter your name' : null,
                      onSaved: (val) => _name = val,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Age'),
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Enter your age';
                        final age = int.tryParse(val);
                        if (age == null || age < 0) return 'Enter a valid age';
                        return null;
                      },
                      onSaved: (val) => _age = int.tryParse(val ?? ''),
                    ),
                    const SizedBox(height: 16),
                    _saving
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _onContinue,
                            child: const Text('Continue'),
                          ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RoseateOS Main Menu')),
      body: const Center(child: Text('Main Menu Placeholder')), // TODO: Replace with Life Dashboard
    );
  }
} 