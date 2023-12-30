import 'package:flutter/material.dart';

class Face3 extends StatelessWidget {
  late final String years;
  late final String months;
  late final String days;
  late final String hours;
  late final String minutes;
  late final String seconds;

  late final String formattedDate;

  late final Function onSelectionCb;
  late final bool isUsedForSelection;

  Face3(this.formattedDate, this.years, this.months, this.days, this.hours,
      this.minutes, this.seconds, this.onSelectionCb, this.isUsedForSelection)
      : super();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isUsedForSelection ? onSelectionCb(2) : (() => {})(),
      child: Transform.scale(
        scale: isUsedForSelection ? 0.8 : 1,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '!وقت می گذرد ولی تو را نمی بینیم، بیا',
                  style: TextStyle(color: Colors.red, fontSize: 32),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    getTimePassedWidget(context, 'Years', years, 5),
                    getTimePassedWidget(context, 'Months', months, 5),
                    getTimePassedWidget(context, 'Days', days, 0),
                    const SizedBox(
                      width: 25,
                    ),
                    getTimePassedWidget(context, 'Hours', hours, 5),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: Text(
                        ':',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    getTimePassedWidget(context, 'Minutes', minutes, 5),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: Text(
                        ':',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
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
      constraints: const BoxConstraints(
        maxHeight: 180.0, // Set the maximum height of the container
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              value,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
