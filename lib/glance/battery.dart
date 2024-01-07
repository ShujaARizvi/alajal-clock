import 'dart:async';

import 'package:battery/battery.dart';
import 'package:flutter/material.dart';

class BatteryPercentage extends StatefulWidget {
  const BatteryPercentage({super.key});

  @override
  _BatteryPercentageState createState() => _BatteryPercentageState();
}

class _BatteryPercentageState extends State<BatteryPercentage> {
  final Battery _battery = Battery();

  late int batteryLevel;

  @override
  void initState() {
    super.initState();

    batteryLevel = 100;

    Timer.periodic(
        const Duration(seconds: 1),
        (timer) => _battery.batteryLevel.then((value) {
              setState(() {
                batteryLevel = value;
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          getBatteryLevelIcon(batteryLevel),
          color: Colors.white,
          size: 54.0,
        ),
        Text(
          '$batteryLevel%',
        ),
      ],
    );
  }

  IconData getBatteryLevelIcon(int batteryLevel) {
    if (batteryLevel == 100) {
      return Icons.battery_charging_full;
    } else if (batteryLevel >= 80) {
      return Icons.battery_6_bar_rounded;
    } else if (batteryLevel >= 60) {
      return Icons.battery_5_bar_rounded;
    } else if (batteryLevel >= 40) {
      return Icons.battery_4_bar_rounded;
    } else if (batteryLevel >= 20) {
      return Icons.battery_3_bar_rounded;
    } else if (batteryLevel >= 10) {
      return Icons.battery_2_bar_rounded;
    } else {
      return Icons.battery_alert_rounded;
    }
  }
}
