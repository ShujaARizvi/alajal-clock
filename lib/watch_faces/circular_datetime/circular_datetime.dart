import 'package:alajal_clock/watch_faces/circular_date/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircularDateTime extends StatelessWidget {
  late final String years;
  late final String months;
  late final String days;
  late final String hours;
  late final String minutes;
  late final String seconds;

  late final Function onSelectionCb;
  late final bool isUsedForSelection;

  CircularDateTime(this.years, this.months, this.days, this.hours, this.minutes,
      this.seconds, this.onSelectionCb, this.isUsedForSelection)
      : super();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isUsedForSelection ? onSelectionCb(8) : (() => {})(),
      child: Transform.scale(
        scale: isUsedForSelection ? 0.8 : 1,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              getLeftStack(context),
              getRightStack(context),
            ],
          ),
        ),
      ),
    );
  }

  getLeftStack(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.longestSide / 2,
          child: Center(
            child: PercentIndicator(
                progress: int.parse(years),
                total: 2000,
                fromColor: Colors.red,
                toColor: Colors.orange,
                radius: 160),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.longestSide / 2,
          child: Center(
            child: PercentIndicator(
              progress: int.parse(months),
              total: 12,
              fromColor: Colors.green,
              toColor: Colors.limeAccent,
              radius: 120,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.longestSide / 2,
          child: Center(
            child: PercentIndicator(
              progress: int.parse(days),
              total: 30,
              fromColor: Colors.purple,
              toColor: Colors.blue,
              radius: 80,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.longestSide / 2,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      getAvatars(
                          Colors.red,
                          'Years',
                          const EdgeInsets.only(
                              left: 3, right: 3, bottom: 8, top: 8)),
                      Text(
                        years,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getAvatars(
                          Colors.green,
                          'Months',
                          const EdgeInsets.only(
                              left: 1, right: 1, bottom: 10, top: 10)),
                      Text(
                        months,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getAvatars(
                          Colors.purple,
                          'Days',
                          const EdgeInsets.only(
                              left: 6, right: 6, bottom: 10, top: 10)),
                      Text(
                        days,
                        style: const TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  getRightStack(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.longestSide / 2,
          child: Center(
            child: PercentIndicator(
              progress: int.parse(hours),
              total: 24,
              fromColor: Colors.red,
              toColor: Colors.orange,
              radius: 160,
              arcType: ArcType.FULL,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.longestSide / 2,
          child: Center(
            child: PercentIndicator(
              progress: int.parse(minutes),
              total: 60,
              fromColor: Colors.green,
              toColor: const Color.fromRGBO(238, 255, 65, 1),
              radius: 120,
              arcType: ArcType.FULL,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.longestSide / 2,
          child: Center(
            child: PercentIndicator(
              progress: int.parse(seconds),
              total: 60,
              fromColor: Colors.purple,
              toColor: Colors.blue,
              radius: 80,
              arcType: ArcType.FULL,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.longestSide / 2,
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getAvatars(
                            Colors.red,
                            'Hours',
                            const EdgeInsets.only(
                                left: 6, right: 6, bottom: 13, top: 13)),
                        Text(
                          hours,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getAvatars(
                            Colors.green,
                            'Minutes',
                            const EdgeInsets.only(
                                left: 2, right: 2, bottom: 13, top: 13)),
                        Text(
                          minutes,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getAvatars(
                            Colors.purple,
                            'Seconds',
                            const EdgeInsets.only(
                                left: 2, right: 2, bottom: 13, top: 13)),
                        Text(
                          seconds,
                          style: const TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  getAvatars(Color color, String value, EdgeInsets paddingInsets) {
    return Container(
        padding: paddingInsets,
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: color,
            width: 0.1,
          ),
        ),
        child: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        ));
  }
}
