import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderPicker extends StatefulWidget {
  const ReminderPicker({super.key});

  @override
  State<ReminderPicker> createState() => ReminderPickerState();
}

class ReminderPickerState extends State<ReminderPicker> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    loadReminderTime();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectTime(context),
      child: Stack(
        children: [
          const Icon(
            Icons.watch_later_rounded,
            color: Colors.white,
            size: 54.0,
          ),
          Container(
            transform: Matrix4.translationValues(0.0, 55.0, 0.0),
            child: const Text(
              'Reminder',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      helpText: 'Set reminder time for Dua',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.black54),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
        setReminderTime(pickedTime);
      });
    }
  }

  Future<void> loadReminderTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.containsKey('reminder_time')) {
        List<String> reminderTimeStr =
            prefs.getString('reminder_time')!.split(':');
        _selectedTime = TimeOfDay(
            hour: int.parse(reminderTimeStr[0]),
            minute: int.parse(reminderTimeStr[1]));
      } else {
        _selectedTime = TimeOfDay.now();
      }
    });
  }

  Future<void> setReminderTime(TimeOfDay reminderTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'reminder_time', '${reminderTime.hour}:${reminderTime.minute}');
  }
}
