import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReminderDialog extends StatefulWidget {
  final String dialogTitle;
  final void Function(String title, DateTime dateTime, String recurrence, int? customInterval) onSet;
  final String? initialTitle;
  final DateTime? initialDateTime;

  const ReminderDialog({
    super.key,
    required this.dialogTitle,
    required this.onSet,
    this.initialTitle,
    this.initialDateTime,
  });

  @override
  State<ReminderDialog> createState() => _ReminderDialogState();
}

class _ReminderDialogState extends State<ReminderDialog> {
  late TextEditingController _titleController;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _recurrence = 'none';
  int? _customInterval;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle ?? '');
    if (widget.initialDateTime != null) {
      _selectedDate = widget.initialDateTime;
      _selectedTime = TimeOfDay.fromDateTime(widget.initialDateTime!);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initialTitle != null && widget.initialDateTime != null;
    return AlertDialog(
      title: Text(widget.dialogTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'Pick Date'
                      : DateFormat.yMMMd().format(_selectedDate!)),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) setState(() => _selectedDate = date);
                  },
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(_selectedTime == null
                      ? 'Pick Time'
                      : _selectedTime!.format(context)),
                ),
                IconButton(
                  icon: const Icon(Icons.access_time),
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: _selectedTime ?? TimeOfDay.now(),
                    );
                    if (time != null) setState(() => _selectedTime = time);
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Repeat:'),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _recurrence,
                  items: const [
                    DropdownMenuItem(value: 'none', child: Text('None')),
                    DropdownMenuItem(value: 'daily', child: Text('Daily')),
                    DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                    DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
                    DropdownMenuItem(value: 'custom', child: Text('Custom')),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _recurrence = val ?? 'none';
                    });
                  },
                ),
                if (_recurrence == 'custom') ...[
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 60,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: 'Days'),
                      onChanged: (val) {
                        setState(() => _customInterval = int.tryParse(val));
                      },
                    ),
                  ),
                  const Text('days'),
                ],
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_titleController.text.isNotEmpty && _selectedDate != null && _selectedTime != null) {
              final dt = DateTime(
                _selectedDate!.year,
                _selectedDate!.month,
                _selectedDate!.day,
                _selectedTime!.hour,
                _selectedTime!.minute,
              );
              widget.onSet(_titleController.text, dt, _recurrence, _customInterval);
              Navigator.of(context).pop();
            }
          },
          child: Text(isEditing ? 'Update Reminder' : 'Set Reminder'),
        ),
      ],
    );
  }
} 