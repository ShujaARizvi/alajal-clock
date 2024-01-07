import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercentIndicator extends StatelessWidget {
  final int progress;
  final int total;

  final Color fromColor;
  final Color toColor;
  final double radius;

  ArcType? arcType;
  double? lineWidth;
  Widget? centerWidget;

  PercentIndicator(
      {super.key,
      required this.progress,
      required this.total,
      required this.fromColor,
      required this.toColor,
      required this.radius,
      this.arcType,
      this.lineWidth,
      this.centerWidget});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius,
      lineWidth: lineWidth ?? 10.0,
      backgroundColor: Colors.white,
      percent: progress / total,
      circularStrokeCap: CircularStrokeCap.round,
      arcType: arcType,
      linearGradient: LinearGradient(colors: [toColor, fromColor]),
      center: centerWidget,
    );
  }
}
