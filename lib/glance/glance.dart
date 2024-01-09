import 'package:alajal_clock/glance/brightness.dart';
import 'package:alajal_clock/glance/reminder_picker.dart';
import 'package:alajal_clock/glance/volume.dart';
import 'package:flutter/material.dart';

import './battery.dart';

class Glance extends StatelessWidget {
  final DateTime date;

  final List<String> dayOfWeek = [
    '',
    'Mon',
    'Tue',
    'Wed',
    'Thur',
    'Fri',
    'Sat',
    'Sun'
  ];

  Glance({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          '${date.month}/${date.day}',
          style: const TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          dayOfWeek[date.weekday],
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        getQuickSettingsGrid(
          [
            const BatteryPercentage(),
            const BrightnessControl(),
            const ReminderPicker(),
          ],
          const VolumeControl(),
        )
      ]),
    );
  }

  getQuickSettingsGrid(List<Widget> gridItems, Widget lastItem) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: gridItems
                .map((element) => Container(
                      margin: const EdgeInsets.all(10),
                      child: element,
                    ))
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [lastItem],
          )
        ],
      ),
    );
  }
}
