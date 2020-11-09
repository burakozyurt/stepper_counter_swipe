import 'package:flutter/material.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
 int val=0;
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
            speedTransitionLimitCount: 1,
            firstIncrementDuration: Duration(milliseconds: 100),
            secondIncrementDuration: Duration(milliseconds: 100),
            direction: Axis.horizontal,
            dragButtonColor: Colors.blueAccent,
            withSpring: true,
            withFastCount:false,
           // withPlusMinus: true,
           // withPressed: true, //add icon pressed 
            maxValue:50,
            //iconSize: 30, add icon size
            stepperValue:widget.val,
            withNaturalNumbers: true,
            onChanged: (int val) => print('New value : $val'),
          ),
        ),
      ),
    );
  }
}
