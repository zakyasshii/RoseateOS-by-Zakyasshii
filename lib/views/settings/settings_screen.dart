import 'package:flutter/material.dart';
import '../../themes/seasonal_theme.dart';
import 'pin_settings_screen.dart';
import '../about/about_screen.dart';
import '../tc/tc_screen.dart';

class SettingsScreen extends StatelessWidget {
  final Season selectedSeason;
  final void Function(Season) onSeasonChanged;
  const SettingsScreen({super.key, required this.selectedSeason, required this.onSeasonChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Seasonal Theme Override', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<Season>(
              value: selectedSeason,
              items: Season.values.map((season) {
                return DropdownMenuItem(
                  value: season,
                  child: Text(season.toString().split('.').last.capitalize()),
                );
              }).toList(),
              onChanged: (season) {
                if (season != null) onSeasonChanged(season);
              },
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PinSettingsScreen()),
                );
              },
              icon: const Icon(Icons.lock),
              label: const Text('PIN Lock Settings'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AboutScreen()),
                );
              },
              icon: const Icon(Icons.info),
              label: const Text('About Us'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const TcScreen()),
                );
              },
              icon: const Icon(Icons.description),
              label: const Text('Terms & Conditions'),
            ),
          ],
        ),
      ),
    );
  }
}

extension StringCasing on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
} 