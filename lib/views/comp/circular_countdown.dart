import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class CountDownCircular extends StatelessWidget {
  const CountDownCircular({
    Key? key,
    required this.sayaczaman,
    required this.degisenZaman,
    required this.kontrolcu,
  }) : super(key: key);
  final int sayaczaman;
  final int degisenZaman;
  final CountDownController kontrolcu;

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: sayaczaman,
      initialDuration: degisenZaman,
      controller: kontrolcu,
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 2,
      ringColor: const Color.fromARGB(255, 65, 4, 4),
      ringGradient: null,
      fillColor: const Color.fromARGB(255, 249, 249, 249),
      fillGradient: null,
      backgroundColor: const Color.fromARGB(255, 126, 0, 0),
      backgroundGradient: null,
      strokeWidth: 15.0,
      strokeCap: StrokeCap.round,
      textStyle: const TextStyle(
          fontSize: 33, color: Colors.white, fontWeight: FontWeight.normal),
      textFormat: CountdownTextFormat.HH_MM_SS,
      isReverse: true,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: false,
      onStart: () {
        debugPrint('Countdown Started');
      },
      onComplete: () {
        debugPrint('Countdown Ended');
      },
      onChange: (String timeStamp) {
        debugPrint('Countdown Changed $timeStamp');
      },
    );
  }
}
