import 'package:flutter/material.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green,
        body: Center(
          child: StepperSwipe(
            initialValue: 0,
            speedTransitionLimitCount: 3,
            firstIncrementDuration: const Duration(milliseconds: 300),
            secondIncrementDuration: const Duration(milliseconds: 100),
            direction: Axis.horizontal,
            dragButtonColor: Colors.blueAccent,
            withSpring: true,
            maxValue: 50,
            minValue: 1,
            withFastCount: true,
            onChanged: (int val) => print('New value : $val'),
            step: 5,
          ),
        ),
      ),
    );
  }
}
