import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:analog_clock/analog_clock.dart';
// import 'package:flutter_analog_clock/flutter_analog_clock.dart';

class Face7 extends StatelessWidget {
  late final String years;
  late final String months;
  late final String days;
  late final String hours;
  late final String minutes;
  late final String seconds;

  late final Function onSelectionCb;
  late final bool isUsedForSelection;

  Face7(this.years, this.months, this.days, this.hours, this.minutes,
      this.seconds, this.onSelectionCb, this.isUsedForSelection)
      : super();

  @override
  Widget build(BuildContext context) {
    AnalogClock analogClock = AnalogClock(
      width: double.infinity,
      height: double.infinity,
      isLive: true,
      hourHandColor: Colors.indigo,
      minuteHandColor: Colors.green,
      showSecondHand: true,
      secondHandColor: Colors.red,
      textScaleFactor: 250.0,
      showTicks: true,
      tickColor: Colors.white,
      showDigitalClock: false,
      showNumbers: false,
      digitalClockColor: Colors.white,
      datetime: DateTime(
          0, 0, 0, int.parse(hours), int.parse(minutes), int.parse(seconds)),
    );

    return GestureDetector(
      onTap: () => isUsedForSelection ? onSelectionCb(6) : (() => {})(),
      child: Transform.scale(
        scale: isUsedForSelection ? 0.8 : 1,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(DateFormat('HH:mm:ss').format(analogClock.datetime!)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  getTimePassedWidget(context, 'Years', years, 5),
                  getCollon(context),
                  getTimePassedWidget(context, 'Months', months, 5),
                  getCollon(context),
                  getTimePassedWidget(context, 'Days', days, 0),
                ],
              ),
              analogClock,
            ],
          ),
        ),
      ),
    );
  }

  getTimePassedWidget(
      BuildContext context, String title, String value, double margin) {
    return Container(
      margin: EdgeInsets.only(right: margin, top: 50),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            Text(value,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: 260, fontFamily: 'Delirium')),
            Container(
              margin: const EdgeInsets.only(top: 250, left: 10),
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 32, fontFamily: 'FiraCode'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding getCollon(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 14.0),
        child: Text(
          ':',
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(fontSize: 180, fontFamily: 'Delirium'),
        ),
      );
}
