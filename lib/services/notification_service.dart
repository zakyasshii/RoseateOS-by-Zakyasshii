import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;
import '../models/reminder.dart';
import '../controllers/reminder_controller.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tzdata.initializeTimeZones();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: ios);
    await _notifications.initialize(settings);
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const android = AndroidNotificationDetails(
      'roseateos_channel',
      'RoseateOS Notifications',
      channelDescription: 'General notifications for RoseateOS',
      importance: Importance.max,
      priority: Priority.high,
    );
    const ios = DarwinNotificationDetails();
    const details = NotificationDetails(android: android, iOS: ios);
    await _notifications.show(id, title, body, details);
  }

  static Future<void> rescheduleAllRecurring() async {
    final controller = ReminderController();
    final reminders = await controller.getReminders();
    final now = DateTime.now();
    for (final reminder in reminders) {
      if (reminder.recurrence != 'none' && reminder.dateTime.isBefore(now)) {
        // Reschedule only if the reminder is recurring and the time has passed
        await rescheduleRecurring(reminder);
        // Update the stored reminder's dateTime to the new scheduled time
        DateTime nextTime = reminder.dateTime;
        switch (reminder.recurrence) {
          case 'daily':
            nextTime = nextTime.add(const Duration(days: 1));
            break;
          case 'weekly':
            nextTime = nextTime.add(const Duration(days: 7));
            break;
          case 'monthly':
            nextTime = DateTime(nextTime.year, nextTime.month + 1, nextTime.day, nextTime.hour, nextTime.minute);
            break;
          case 'custom':
            if (reminder.customInterval != null && reminder.customInterval! > 0) {
              nextTime = nextTime.add(Duration(days: reminder.customInterval!));
            }
            break;
        }
        final updated = reminder
          ..dateTime = nextTime;
        await controller.updateReminder(reminder.id, updated);
      }
    }
  }

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    if (scheduledTime.isBefore(DateTime.now())) {
      // Don't schedule notifications in the past
      return;
    }
    try {
      const android = AndroidNotificationDetails(
        'roseateos_channel',
        'RoseateOS Notifications',
        channelDescription: 'General notifications for RoseateOS',
        importance: Importance.max,
        priority: Priority.high,
      );
      const ios = DarwinNotificationDetails();
      const details = NotificationDetails(android: android, iOS: ios);
      await _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledTime, tz.local),
        details,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (e) {
      // Handle notification permission errors or other issues
      // Optionally log or show a message
    }
  }

  static Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  static Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }

  static Future<void> rescheduleRecurring(Reminder reminder) async {
    DateTime nextTime = reminder.dateTime;
    switch (reminder.recurrence) {
      case 'daily':
        nextTime = nextTime.add(const Duration(days: 1));
        break;
      case 'weekly':
        nextTime = nextTime.add(const Duration(days: 7));
        break;
      case 'monthly':
        nextTime = DateTime(nextTime.year, nextTime.month + 1, nextTime.day, nextTime.hour, nextTime.minute);
        break;
      case 'custom':
        if (reminder.customInterval != null && reminder.customInterval! > 0) {
          nextTime = nextTime.add(Duration(days: reminder.customInterval!));
        }
        break;
      default:
        return;
    }
    await scheduleNotification(
      id: reminder.id,
      title: '${reminder.type[0].toUpperCase()}${reminder.type.substring(1)} Reminder',
      body: reminder.title,
      scheduledTime: nextTime,
    );
  }
} 