import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class Face1 extends StatelessWidget {
  late final String years;
  late final String months;
  late final String days;
  late final String hours;
  late final String minutes;
  late final String seconds;

  late final String formattedDate;

  late final Function onSelectionCb;
  late final bool isUsedForSelection;

  Face1(this.formattedDate, this.years, this.months, this.days, this.hours,
      this.minutes, this.seconds, this.onSelectionCb, this.isUsedForSelection)
      : super();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isUsedForSelection ? onSelectionCb(0) : (() => {})(),
      child: Transform.scale(
        scale: isUsedForSelection ? 0.8 : 1,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    getTimePassedWidget(context, 'Years', years, 5),
                    getTimePassedWidget(context, 'Months', months, 5),
                    getTimePassedWidget(context, 'Days', days, 0),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 180.0,
                      width: 1.0,
                      color: Colors.white,
                    ),
                    getTimePassedWidget(context, 'Hours', hours, 5),
                    getTimePassedWidget(context, 'Minutes', minutes, 5),
                    getTimePassedWidget(context, 'Seconds', seconds, 0),
                  ],
                ),
                Text(
                  formattedDate,
                  style: const TextStyle(fontFamily: 'Robotto'),
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
                      color: Color.fromRGBO(41, 40, 40, 1), width: 1.5),
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
