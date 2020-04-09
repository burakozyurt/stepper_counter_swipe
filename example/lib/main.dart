import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SafeArea(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: StepperSwipe(
                          initialValue:0,
                          speedTransitionLimitCount: 3,
                          firstIncrementDuration: Duration(milliseconds: 500),
                          withPlusMinus: true,
                          dragButtonColor: Colors.blue,
                          direction: Axis.vertical,
                          withSpring: false,
                          withNaturalNumbers: false,
                          onChanged: (int value) => print('new value $value'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: StepperSwipe(
                          initialValue:0,
                          speedTransitionLimitCount: 3,
                          firstIncrementDuration: Duration(milliseconds: 500),
                          withPlusMinus: false,
                          dragButtonColor: Colors.blue,
                          direction: Axis.vertical,
                          withSpring: false,
                          withNaturalNumbers: false,
                          onChanged: (int value) => print('new value $value'),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: StepperSwipe(
                            dragButtonColor: Colors.blue,
                            initialValue: 0,
                            onChanged: (int value) => print('new value $value'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: StepperSwipe(
                            dragButtonColor: Colors.blue,
                            withBackground: false,
                            withNaturalNumbers: true,
                            initialValue: 0,
                            onChanged: (int value) => print('new value $value'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: StepperSwipe(
                            dragButtonColor: Colors.blue,
                            withPlusMinus: true,
                            initialValue: 0,
                            onChanged: (int value) => print('new value $value'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: StepperSwipe(
                          initialValue:0,
                          speedTransitionLimitCount: 3,
                          firstIncrementDuration: Duration(milliseconds: 500),
                          withPlusMinus: true,
                          dragButtonColor: Colors.blue,
                          direction: Axis.vertical,
                          withSpring: false,
                          withNaturalNumbers: false,
                          onChanged: (int value) => print('new value $value'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: StepperSwipe(
                          initialValue:0,
                          speedTransitionLimitCount: 3,
                          firstIncrementDuration: Duration(milliseconds: 500),
                          withPlusMinus: false,
                          dragButtonColor: Colors.blue,
                          direction: Axis.vertical,
                          withSpring: false,
                          withNaturalNumbers: false,
                          onChanged: (int value) => print('new value $value'),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
