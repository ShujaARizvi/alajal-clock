import 'package:alajal_clock/watch_faces/face4/percent_indicator.dart';
import 'package:flutter/material.dart';

class Face4 extends StatelessWidget {
  late final String years;
  late final String months;
  late final String days;
  late final String hours;
  late final String minutes;
  late final String seconds;

  late final String formattedDate;

  late final Function onSelectionCb;
  late final bool isUsedForSelection;

  Face4(this.formattedDate, this.years, this.months, this.days, this.hours,
      this.minutes, this.seconds, this.onSelectionCb, this.isUsedForSelection)
      : super();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isUsedForSelection ? onSelectionCb(3) : (() => {})(),
      child: Transform.scale(
        scale: isUsedForSelection ? 0.8 : 1,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Stack(
              children: [
                Center(
                  child: PercentIndicator(
                      progress: int.parse(years),
                      total: 2000,
                      fromColor: Colors.red,
                      toColor: Colors.orange,
                      radius: 200),
                ),
                Center(
                  child: PercentIndicator(
                    progress: int.parse(months),
                    total: 12,
                    fromColor: Colors.green,
                    toColor: Colors.limeAccent,
                    radius: 160,
                  ),
                ),
                Center(
                  child: PercentIndicator(
                    progress: int.parse(days),
                    total: 30,
                    fromColor: Colors.purple,
                    toColor: Colors.blue,
                    radius: 120,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            getAvatars(
                                Colors.red,
                                'Years',
                                const EdgeInsets.only(
                                    left: 7, right: 7, bottom: 18, top: 18)),
                            Text(years),
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
                                    left: 2, right: 2, bottom: 20, top: 20)),
                            Text(months),
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
                                    left: 12, right: 12, bottom: 20, top: 20)),
                            Text(days)
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
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
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
  }
}
