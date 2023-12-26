import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:wakelock_plus/wakelock_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  WakelockPlus.enable();

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

    return MaterialApp(
      title: 'AlAjal Clock',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Digital7',
        textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
            headlineLarge: TextStyle(color: Colors.white, fontSize: 88)),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          background: Colors.transparent,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DateTime targetDate;

  late String _years;
  late String _months;
  late String _days;

  late String _hours;
  late String _minutes;
  late String _seconds;

  _MyHomePageState() {
    targetDate = DateTime.utc(941, 6, 7);
  }
  @override
  void initState() {
    super.initState();
    Timer.periodic(
        const Duration(seconds: 1),
        (timer) => setState(() {
              updateClock();
            }));
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, MMMM dd, yyyy HH:mm').format(now);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Text(
              //   'این قدر وقت گذشت که تو رو ندیدیم، بیا',
              //   style: TextStyle(color: Colors.red, fontSize: 32),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  getTimePassedWidget('Years', _years, 5),
                  getTimePassedWidget('Months', _months, 5),
                  getTimePassedWidget('Days', _days, 0),
                  // const SizedBox(
                  //   width: 25,
                  // ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 180.0, // Adjust the height of the line
                    width: 1.0, // Adjust the width of the line
                    color: Colors.white,
                  ),
                  getTimePassedWidget('Hours', _hours, 5),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 14.0),
                  //   child: Text(
                  //     ':',
                  //     style: Theme.of(context).textTheme.headlineLarge,
                  //   ),
                  // ),
                  getTimePassedWidget('Minutes', _minutes, 5),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 14.0),
                  //   child: Text(
                  //     ':',
                  //     style: Theme.of(context).textTheme.headlineLarge,
                  //   ),
                  // ),
                  getTimePassedWidget('Seconds', _seconds, 0),
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
    );
  }

  getTimePassedWidget(String title, String value, double margin) {
    return Container(
      margin: EdgeInsets.only(right: margin),
      constraints: const BoxConstraints(
        maxHeight: 180.0, // Set the maximum height of the container
      ),
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
              child: Text(
                value,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
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
}
