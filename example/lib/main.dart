import 'package:flutter/material.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green,
        body: Center(
          child: StepperSwipe(
            initialValue:0,
            speedTransitionLimitCount: 3,
            firstIncrementDuration: Duration(milliseconds: 250),
            secondIncrementDuration: Duration(milliseconds: 100),
            direction: Axis.horizontal,
            dragButtonColor: Colors.blueAccent,
            withSpring: true,
            maxValue:5,
            withNaturalNumbers: true,
            onChanged: (int val) => print('New value : $val'),
          ),
        ),
      ),
    );
  }
}
