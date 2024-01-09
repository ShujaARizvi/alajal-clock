import 'dart:async';

import 'package:alajal_clock/watch_faces/circular_date/percent_indicator.dart';
import 'package:battery/battery.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Basic extends StatefulWidget {
  late final String years;
  late final String months;
  late final String days;
  late final String hours;
  late final String minutes;
  late final String seconds;

  late final DateTime currentDate;

  late final Function onSelectionCb;
  late final bool isUsedForSelection;

  Basic(this.currentDate, this.years, this.months, this.days, this.hours,
      this.minutes, this.seconds, this.onSelectionCb, this.isUsedForSelection)
      : super();

  @override
  State<Basic> createState() => _BasicState();
}

class _BasicState extends State<Basic> {
  final Battery _battery = Battery();

  late int batteryLevel;

  late Timer batteryPollingTimer;

  final List<String> dayOfWeek = [
    '',
    'MON',
    'TUE',
    'WED',
    'THUR',
    'FRI',
    'SAT',
    'SUN'
  ];

  @override
  void initState() {
    super.initState();

    batteryLevel = 100;

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
    return GestureDetector(
      onTap: () =>
          widget.isUsedForSelection ? widget.onSelectionCb(0) : (() => {})(),
      child: Transform.scale(
        scale: widget.isUsedForSelection ? 0.8 : 1,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PercentIndicator(
                  progress: batteryLevel,
                  total: 100,
                  fromColor: Colors.green,
                  toColor: Colors.red,
                  radius: 20,
                  lineWidth: 3,
                  centerWidget: const Icon(
                    Icons.electric_bolt,
                    color: Colors.white,
                  ),
                  arcType: ArcType.FULL,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    getTimePassedWidget(context, 'Years', widget.years, 5),
                    getTimePassedWidget(context, 'Months', widget.months, 5),
                    getTimePassedWidget(context, 'Days', widget.days, 0),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 180.0,
                      width: 1.0,
                      color: Colors.white,
                    ),
                    getTimePassedWidget(context, 'Hours', widget.hours, 5),
                    getTimePassedWidget(context, 'Minutes', widget.minutes, 5),
                    getTimePassedWidget(context, 'Seconds', widget.seconds, 0),
                  ],
                ),
                Text(
                  widget.currentDate.day < 10
                      ? '0${widget.currentDate.day}'
                      : '${widget.currentDate.day}',
                  style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 34),
                ),
                Text(
                  dayOfWeek[widget.currentDate.weekday],
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getTimePassedWidget(
      BuildContext context, String title, String value, double margin) {
    return Container(
      margin: EdgeInsets.only(right: margin),
      constraints: const BoxConstraints(maxHeight: 180.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 26, 26, 27),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      // color: Color.fromRGBO(41, 40, 40, 1), width: 1.5),
                      color: Colors.grey,
                      width: 1.5),
                ),
              ),
              child:
                  Text(value, style: Theme.of(context).textTheme.headlineLarge),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
