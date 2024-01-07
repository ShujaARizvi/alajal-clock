import 'dart:async';

import 'package:flutter/material.dart';

class EdgeCircular extends StatefulWidget {
  late final String years;
  late final String months;
  late final String days;
  late final String hours;
  late final String minutes;
  late final String seconds;

  late final Function onSelectionCb;
  late final bool isUsedForSelection;

  EdgeCircular(this.years, this.months, this.days, this.hours, this.minutes,
      this.seconds, this.onSelectionCb, this.isUsedForSelection)
      : super();

  @override
  State<EdgeCircular> createState() => _EdgeCircularState();
}

class _EdgeCircularState extends State<EdgeCircular> {
  double _secondsProgressValue = 0.00;

  @override
  void initState() {
    super.initState();

    Timer.periodic(
        const Duration(milliseconds: 10),
        (timer) => setState(() {
              _secondsProgressValue += 0.0025;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          widget.isUsedForSelection ? widget.onSelectionCb(7) : (() => {})(),
      child: Transform.scale(
        scale: widget.isUsedForSelection ? 0.8 : 1,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Positioned(
                top: 100,
                child: SizedBox(
                  height: 10,
                  child: LinearProgressIndicator(
                    color: Colors.green,
                    backgroundColor: Colors.transparent,
                    value: _secondsProgressValue,
                  ),
                ),
              ),
              Positioned(
                top: 100,
                bottom: 10,
                left: 540,
                right: 0,
                child: Transform.rotate(
                    angle: 33,
                    child: SizedBox(
                      height: 1,
                      child: LinearProgressIndicator(
                        color: Colors.green,
                        backgroundColor: Colors.transparent,
                        value: _secondsProgressValue,
                      ),
                    )),
              ),
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
