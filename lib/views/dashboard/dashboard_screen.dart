import 'package:flutter/material.dart';
import '../../themes/seasonal_theme.dart';
import '../planner/planner_screen.dart';
import '../calendar/calendar_screen.dart';
import '../goals/goals_screen.dart';
import '../finance/finance_screen.dart';
import '../notes/notes_screen.dart';
import '../contacts/contacts_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = SeasonalTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Life Dashboard'),
        backgroundColor: theme.primaryColor,
      ),
      body: Container(
        color: theme.backgroundColor,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _DashboardButton(title: 'Daily Planner', icon: Icons.today, onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PlannerScreen()));
            }),
            _DashboardButton(title: 'Calendar & Events', icon: Icons.calendar_month, onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CalendarScreen()));
            }),
            _DashboardButton(title: 'Goals & Targets', icon: Icons.flag, onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const GoalsScreen()));
            }),
            _DashboardButton(title: 'Progress Meters', icon: Icons.show_chart, onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const GoalsScreen()));
            }),
            _DashboardButton(title: 'Financial Tracker', icon: Icons.attach_money, onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const FinanceScreen()));
            }),
            _DashboardButton(title: 'Notes & Ideas', icon: Icons.note, onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NotesScreen()));
            }),
            _DashboardButton(title: 'Business Contacts', icon: Icons.contacts, onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ContactsScreen()));
            }),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed('/settings');
              },
              icon: const Icon(Icons.settings),
              label: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const _DashboardButton({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
} 