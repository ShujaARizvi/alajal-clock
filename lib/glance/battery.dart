import 'package:battery/battery.dart';
import 'package:flutter/material.dart';

class BatteryPercentageWidget extends StatefulWidget {
  const BatteryPercentageWidget({super.key});

  @override
  _BatteryPercentageWidgetState createState() =>
      _BatteryPercentageWidgetState();
}

class _BatteryPercentageWidgetState extends State<BatteryPercentageWidget> {
  final Battery _battery = Battery();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _battery.batteryLevel,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          int batteryLevel = snapshot.data!;
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
      },
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