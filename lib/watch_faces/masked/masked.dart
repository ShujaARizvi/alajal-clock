import 'package:alajal_clock/watch_faces/masked/masked_image.dart';
import 'package:flutter/material.dart';

class Masked extends StatelessWidget {
  late final String years;
  late final String months;
  late final String days;
  late final String hours;
  late final String minutes;
  late final String seconds;

  late final String message;
  late final int onSelectionIdx;

  late final Function onSelectionCb;
  late final bool isUsedForSelection;

  Masked(
      this.years,
      this.months,
      this.days,
      this.hours,
      this.minutes,
      this.seconds,
      this.onSelectionCb,
      this.isUsedForSelection,
      this.message,
      this.onSelectionIdx)
      : super();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          isUsedForSelection ? onSelectionCb(onSelectionIdx) : (() => {})(),
      child: Transform.scale(
        scale: isUsedForSelection ? 0.8 : 1,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 231, 229, 229),
          body: MaskedImage(
            image: const AssetImage('assets/images/jamkaran_3.jpeg'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  message,
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    getTimePassedWidget(context, 'Years', years, 5),
                    getTimePassedWidget(context, 'Months', months, 5),
                    getTimePassedWidget(context, 'Days', days, 0),
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: 1.0,
                      color: Colors.transparent,
                    ),
                    getTimePassedWidget(context, 'Hours', hours, 5),
                    getCollon(context),
                    getTimePassedWidget(context, 'Minutes', minutes, 5),
                    getCollon(context),
                    getTimePassedWidget(context, 'Seconds', seconds, 0),
                  ],
                )
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
      margin: EdgeInsets.only(right: margin, top: 50),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(value,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: 176, fontFamily: 'Delirium')),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontSize: 32, fontFamily: 'Delirium'),
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
