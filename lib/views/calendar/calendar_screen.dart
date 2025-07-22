import 'package:flutter/material.dart';
import '../common/reminder_dialog.dart';
import '../../services/notification_service.dart';
import '../../controllers/reminder_controller.dart';
import '../../models/reminder.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<Reminder> _reminders = [];
  final _reminderController = ReminderController();

  Future<void> _loadReminders() async {
    final all = await _reminderController.getReminders();
    setState(() {
      _reminders = all.where((r) => r.type == 'event').toList();
    });
  }

  Future<void> _addEventReminder(String title, DateTime dateTime, String recurrence, int? customInterval) async {
    final id = DateTime.now().millisecondsSinceEpoch % 1000000;
    await NotificationService.scheduleNotification(
      id: id,
      title: 'Event Reminder',
      body: title,
      scheduledTime: dateTime,
    );
    await _reminderController.addReminder(
      Reminder(id: id, title: title, dateTime: dateTime, type: 'event', recurrence: recurrence, customInterval: customInterval),
    );
    await _loadReminders();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Event and reminder scheduled!')),
      );
    }
  }

  Future<void> _deleteReminder(Reminder reminder) async {
    await NotificationService.cancelNotification(reminder.id);
    await _reminderController.deleteReminder(reminder.id);
    await _loadReminders();
  }

  Future<void> _editReminder(Reminder reminder) async {
    await showDialog(
      context: context,
      builder: (context) => ReminderDialog(
        dialogTitle: 'Edit Event Reminder',
        initialTitle: reminder.title,
        initialDateTime: reminder.dateTime,
        onSet: (newTitle, newDateTime, recurrence, customInterval) async {
          await NotificationService.cancelNotification(reminder.id);
          await NotificationService.scheduleNotification(
            id: reminder.id,
            title: 'Event Reminder',
            body: newTitle,
            scheduledTime: newDateTime,
          );
          final updated = Reminder(
            id: reminder.id,
            title: newTitle,
            dateTime: newDateTime,
            type: 'event',
            recurrence: recurrence,
            customInterval: customInterval,
          );
          await _reminderController.updateReminder(reminder.id, updated);
          await _loadReminders();
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Reminder updated!')),
            );
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    NotificationService.init();
    _loadReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar & Events')),
      body: ListView.builder(
        itemCount: _reminders.length,
        itemBuilder: (context, index) {
          final reminder = _reminders[index];
          return ListTile(
            title: Text(reminder.title),
            subtitle: Text(DateFormat.yMMMd().add_jm().format(reminder.dateTime)),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteReminder(reminder),
            ),
            onTap: () => _editReminder(reminder),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) => ReminderDialog(
              dialogTitle: 'Add Event & Reminder',
              onSet: _addEventReminder,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
} 