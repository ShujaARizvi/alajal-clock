import 'dart:async';

import 'package:alajal_clock/glance/glance.dart';
import 'package:alajal_clock/reminder/reminder.dart';
import 'package:alajal_clock/watch_faces/circular_date/circular_date.dart';
import 'package:alajal_clock/watch_faces/circular_datetime/circular_datetime.dart';
import 'package:alajal_clock/watch_faces/masked/masked.dart';
import 'package:alajal_clock/watch_faces/analog/analog.dart';
import 'package:vibration/vibration.dart';

import 'package:alajal_clock/watch_faces/basic/basic.dart';
import 'package:alajal_clock/watch_faces/dynamic/dynamic.dart';
import 'package:alajal_clock/watch_faces/message_basic/message_basic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wakelock_plus/wakelock_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  WakelockPlus.enable();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    final ThemeData theme = ThemeData(
      primarySwatch: Colors.green,
      fontFamily: 'FiraCode',
    );

    return MaterialApp(
      title: 'AlAjal Clock',
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyMedium: const TextStyle(color: Colors.white, fontSize: 22),
            bodyLarge: const TextStyle(
                color: Colors.white, fontSize: 68, fontWeight: FontWeight.bold),
            headlineMedium: const TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: 'Digital7'),
            headlineLarge: const TextStyle(
                color: Colors.white, fontSize: 102, fontFamily: 'Digital7')),
        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: Colors.deepPurple,
        //   background: Colors.black,
        // ),
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DateTime targetDate;

  late String _years = '';
  late String _months;
  late String _days;

  late String _hours;
  late String _minutes;
  late String _seconds;

  bool _isWatchFaceSelectionEnabled = false;
  bool _isUsedForSelection = false;
  late int _currentWatchFaceIdx;
  late int _currentVerticalPage;
  late List<Widget> watchFaces;

  static const _volumeBtnChannel = MethodChannel("mychannel");

  DateTime currentDate = DateTime.now();

  _MyHomePageState() {
    targetDate = DateTime.utc(941, 6, 7);
  }

  @override
  void initState() {
    super.initState();

    _volumeBtnChannel.setMethodCallHandler((call) {
      if (call.method == "volumeBtnPressed") {
        if (call.arguments == "volume_down") {
          changeWatchFaceDown();
        } else if (call.arguments == "volume_up") {
          changeWatchFaceUp();
        }
      }

      return Future.value(null);
    });

    _currentWatchFaceIdx = 0;
    _currentVerticalPage = 1;
    // DateFormat('EEEE, MMMM dd, yyyy HH:mm').format(DateTime.now());

    Timer.periodic(
        const Duration(seconds: 1),
        (timer) => setState(() {
              updateClock();
              currentDate = DateTime.now();
            }));
  }

  changeWatchFaceDown() {
    setState(() {
      _currentWatchFaceIdx -= 1;
      if (_currentWatchFaceIdx < 0) {
        _currentWatchFaceIdx = watchFaces.length - 1;
      }
    });
  }

  changeWatchFaceUp() {
    setState(() {
      _currentWatchFaceIdx = (_currentWatchFaceIdx + 1) % watchFaces.length;
    });
  }

  jumpToHome() {
    print('home pressed');
    setState(() {
      _currentVerticalPage = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    watchFaces = [
      Basic(currentDate, _years, _months, _days, _hours, _minutes, _seconds,
          onWatchFaceSelected, _isUsedForSelection),
      Analog(_years, _months, _days, _hours, _minutes, _seconds,
          onWatchFaceSelected, _isUsedForSelection),
      MessageBasic(
          _years,
          _months,
          _days,
          _hours,
          _minutes,
          _seconds,
          onWatchFaceSelected,
          _isUsedForSelection,
          '!وقت می گذرد ولی تو را نمی بینیم، بیا',
          2),
      MessageBasic(
          _years,
          _months,
          _days,
          _hours,
          _minutes,
          _seconds,
          onWatchFaceSelected,
          _isUsedForSelection,
          '!این خانواده منتظر ظهور هست',
          3),
      Dynamic(_years, _months, _days, _hours, _minutes, _seconds,
          onWatchFaceSelected, _isUsedForSelection),
      Masked(
          _years,
          _months,
          _days,
          _hours,
          _minutes,
          _seconds,
          onWatchFaceSelected,
          _isUsedForSelection,
          '!وقت می گذرد ولی تو را نمی بینیم، بیا',
          5),
      Masked(
          _years,
          _months,
          _days,
          _hours,
          _minutes,
          _seconds,
          onWatchFaceSelected,
          _isUsedForSelection,
          '!این خانواده منتظر ظهور هست',
          6),
      CircularDate(_years, _months, _days, _hours, _minutes, _seconds,
          onWatchFaceSelected, _isUsedForSelection),
      CircularDateTime(_years, _months, _days, _hours, _minutes, _seconds,
          onWatchFaceSelected, _isUsedForSelection),
    ];

    return Scaffold(
      drawerEdgeDragWidth: 0.0,
      drawerEnableOpenDragGesture: false,
      backgroundColor: Colors.transparent,
      body: WillPopScope(
          onWillPop: () async => false,
          child: _isWatchFaceSelectionEnabled
              ? getHorizontalPageView()
              : getVerticalPageView()),
    );
  }

  getVerticalPageView() {
    return PageView(
      scrollDirection: Axis.vertical,
      controller: PageController(initialPage: _currentVerticalPage),
      children: [
        Glance(date: DateTime.now()),
        GestureDetector(
            onLongPress: () => setState(() {
                  _isWatchFaceSelectionEnabled = true;
                  _isUsedForSelection = true;

                  Vibration.vibrate(duration: 100);
                }),
            child: watchFaces[_currentWatchFaceIdx]),
        const Reminders()
      ],
    );
  }

  getHorizontalPageView() {
    return Stack(
      children: [
        PageView.builder(
          controller: PageController(initialPage: _currentWatchFaceIdx),
          onPageChanged: (int page) {
            setState(() {
              _currentWatchFaceIdx = page;
            });
          },
          itemCount: watchFaces.length,
          itemBuilder: (BuildContext context, int index) {
            return watchFaces[index % watchFaces.length];
          },
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 10,
            child: Container(
              color: Colors.transparent,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                      watchFaces.length,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CircleAvatar(
                              radius: 8,
                              backgroundColor: _currentWatchFaceIdx == index
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          ))),
            )),
      ],
    );
  }

  void updateClock() {
    final currentDate = DateTime.now().toUtc();
    final Duration timeDifference = currentDate.difference(targetDate);

    // Calculate elapsed time
    _years = (timeDifference.inDays ~/ 365.25).toString();
    _months = ((timeDifference.inDays % 365.25) ~/ 30).toString();
    _days = (timeDifference.inDays % 30).toString();
    _hours = (timeDifference.inHours % 24).toString();
    _minutes = (timeDifference.inMinutes % 60).toString();
    _seconds = (timeDifference.inSeconds % 60).toString();

    _years = _years.length == 1
        ? '000$_years'
        : _years.length == 2
            ? '00$_years'
            : _years.length == 3
                ? '0$_years'
                : _years;
    _months = _months.length == 1 ? '0$_months' : _months;
    _days = _days.length == 1 ? '0$_days' : _days;
    _hours = _hours.length == 1 ? '0$_hours' : _hours;
    _minutes = _minutes.length == 1 ? '0$_minutes' : _minutes;
    _seconds = _seconds.length == 1 ? '0$_seconds' : _seconds;
  }

  void onWatchFaceSelected(int watchFaceIndex) {
    setState(() {
      _isWatchFaceSelectionEnabled = false;
      _isUsedForSelection = false;
      _currentWatchFaceIdx = watchFaceIndex;

      Vibration.vibrate(duration: 100);
    });
  }
}
