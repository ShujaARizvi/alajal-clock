import 'package:alajal_clock/glance/brightness.dart';
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
            [const BatteryPercentage(), const BrightnessControl()])
      ]),
    );
  }

  getQuickSettingsGrid(List<Widget> gridItems) {
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: gridItems
            .map((element) => Container(
                  margin: const EdgeInsets.all(10),
                  child: element,
                ))
            .toList(),
      ),
    );
  }
}
