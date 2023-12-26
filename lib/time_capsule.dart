import 'dart:async';

void main() {
  final targetDate = DateTime.utc(941, 6, 7);

  void updateClock() {
    final currentDate = DateTime.now().toUtc();
    final Duration timeDifference = currentDate.difference(targetDate);

    // Calculate elapsed time
    final years = timeDifference.inDays ~/ 365.25;
    final months = (timeDifference.inDays % 365.25) ~/ 30;
    final days = timeDifference.inDays % 30;
    final hours = timeDifference.inHours % 24;
    final minutes = timeDifference.inMinutes % 60;
    final seconds = timeDifference.inSeconds % 60;

    // Display the elapsed time
    print('$years y $months mo $days d $hours h $minutes m $seconds s');
  }

  // Update the clock every second
  Timer.periodic(const Duration(seconds: 1), (timer) => updateClock());

  // Initial update
  updateClock();
}
