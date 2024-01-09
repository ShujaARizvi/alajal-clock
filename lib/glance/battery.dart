import 'dart:async';

import 'package:battery/battery.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BatteryPercentage extends StatefulWidget {
  const BatteryPercentage({super.key});

  @override
  _BatteryPercentageState createState() => _BatteryPercentageState();
}

class _BatteryPercentageState extends State<BatteryPercentage> {
  final Battery _battery = Battery();
  late Timer batteryPollingTimer;

  int batteryLevel = 100;

  @override
  void initState() {
    super.initState();

    batteryPollingTimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) => _battery.batteryLevel.then((value) {
              setState(() {
                batteryLevel = value;
              });
            }));
  }

  @override
  void dispose() {
    batteryPollingTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(
          getBatteryLevelIcon(batteryLevel),
          color: Colors.white,
          size: 54.0,
        ),
        Container(
          transform: Matrix4.translationValues(14.0, 55.0, 0.0),
          child: Text(
            '$batteryLevel%',
            style: const TextStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
          ),
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
