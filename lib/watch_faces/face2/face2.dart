import 'package:alajal_clock/watch_faces/face2/background_specifics.dart';
import 'package:flutter/material.dart';

class Face2 extends StatelessWidget {
  late final String years;
  late final String months;
  late final String days;
  late final String hours;
  late final String minutes;
  late final String seconds;

  late final Function onSelectionCb;
  late final bool isUsedForSelection;

  Face2(this.years, this.months, this.days, this.hours, this.minutes,
      this.seconds, this.onSelectionCb, this.isUsedForSelection)
      : super();

  @override
  Widget build(BuildContext context) {
    final specifics = getSpecificsByHour();

    return GestureDetector(
      onTap: () => isUsedForSelection ? onSelectionCb(1) : (() => {})(),
      child: Transform.scale(
          scale: isUsedForSelection ? 0.80 : 1,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(specifics.imagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(top: specifics.marginTop),
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
                        width: 100.0,
                        color: Colors.transparent,
                      ),
                      getTimePassedWidget(context, 'Hours', hours, 5),
                      getTimePassedWidget(context, 'Minutes', minutes, 5),
                      getTimePassedWidget(context, 'Seconds', seconds, 0),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  getTimePassedWidget(
      BuildContext context, String title, String value, double margin) {
    return Container(
      margin: EdgeInsets.only(right: margin),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              value,
              style: getTextStyleByHour(context),
              // style: ,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                shadows: const <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 2.0,
                    color: Color.fromRGBO(77, 77, 77, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle? getTextStyleByHour(BuildContext context) {
    final currentHour = DateTime.now().hour;
    if ((currentHour >= 0 && currentHour <= 6) || (currentHour >= 19)) {
      return Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: const Color.fromARGB(255, 233, 240, 252),
        shadows: const <Shadow>[
          Shadow(
            offset: Offset(0.0, 0.0),
            blurRadius: 2.0,
            color: Color.fromRGBO(56, 69, 247, 1),
          ),
        ],
      );
    } else if (currentHour >= 7 && currentHour <= 18) {
      return Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: const Color.fromRGBO(255, 214, 166, 1),
        shadows: const <Shadow>[
          Shadow(
            offset: Offset(0.0, 0.0),
            blurRadius: 2.0,
            color: Color.fromRGBO(149, 80, 0, 1),
          ),
        ],
      );
    } else {
      return Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: const Color.fromARGB(255, 233, 240, 252),
        shadows: const <Shadow>[
          Shadow(
            offset: Offset(0.0, 0.0),
            blurRadius: 2.0,
            color: Color.fromRGBO(56, 69, 247, 1),
          ),
        ],
      );
    }
  }

  BackgroundSpecifics getSpecificsByHour() {
    String? imagePath;
    double marginTop;

    final currentHour = DateTime.now().hour;

    if ((currentHour >= 0 && currentHour <= 6) || (currentHour >= 19)) {
      imagePath = 'assets/images/jamkaran_night.jpeg';
      marginTop = 60.0;
    } else if (currentHour >= 7 && currentHour <= 18) {
      imagePath = 'assets/images/jamkaran_eve.jpeg';
      marginTop = 100.0;
    } else {
      imagePath = 'assets/images/jamkaran_day.jpeg';
      marginTop = 0.0;
    }

    return BackgroundSpecifics(imagePath, marginTop);
  }
}
