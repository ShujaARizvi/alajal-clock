import 'package:alajal_clock/reminder/reminder_data.dart';
import 'package:flutter/material.dart';

class ReminderItem extends StatelessWidget {
  final ReminderData data;

  const ReminderItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Text('Imam (ajtf) says:'),
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade50.withOpacity(0.15),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(width: 0.0)),
          height: 190,
          width: 2340,
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(data.message),
          ),
        ),
      ],
    );
  }
}
