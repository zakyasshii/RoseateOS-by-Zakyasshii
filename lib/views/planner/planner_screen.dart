import 'package:flutter/material.dart';
import '../../services/notification_service.dart';
import 'package:intl/intl.dart';
import '../../controllers/reminder_controller.dart';
import '../../models/reminder.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  List<Reminder> _reminders = [];
  final _reminderController = ReminderController();

  Future<void> _loadReminders() async {
    final all = await _reminderController.getReminders();
    setState(() {
      _reminders = all.where((r) => r.type == 'task').toList();
    });
  }

  Future<void> _addTaskReminder(String title, DateTime dateTime, String recurrence, int? customInterval) async {
    final id = DateTime.now().millisecondsSinceEpoch % 1000000;
    await NotificationService.scheduleNotification(
      id: id,
      title: 'Task Reminder',
      body: title,
      scheduledTime: dateTime,
    );
    await _reminderController.addReminder(
      Reminder(id: id, title: title, dateTime: dateTime, type: 'task', recurrence: recurrence, customInterval: customInterval),
    );
    await _loadReminders();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task and reminder scheduled!')),
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
        dialogTitle: 'Edit Task Reminder',
        initialTitle: reminder.title,
        initialDateTime: reminder.dateTime,
        onSet: (newTitle, newDateTime, recurrence, customInterval) async {
          await NotificationService.cancelNotification(reminder.id);
          await NotificationService.scheduleNotification(
            id: reminder.id,
            title: 'Task Reminder',
            body: newTitle,
            scheduledTime: newDateTime,
          );
          final updated = Reminder(
            id: reminder.id,
            title: newTitle,
            dateTime: newDateTime,
            type: 'task',
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
      appBar: AppBar(title: const Text('Daily Planner & To-Do List')),
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
              dialogTitle: 'Add Task & Reminder',
              onSet: _addTaskReminder,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
} 