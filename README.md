# stepper_counter_swipe
<a href="https://stackoverflow.com/questions/tagged/flutter?sort=votes">
   <img alt="Awesome Flutter" src="https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square" />
</a>

 the concept of the widget inspired
 from [Nikolay Kuchkarov](https://dribbble.com/shots/5639404-Stepper-XVIII).
 i extended  the functionality to be more useful in real world applications

# gif
<img src="https://github.com/burakozyurt/stepper_counter_swipe/blob/master/documents/blue.gif?raw=true" width="300"/> <img src="https://github.com/burakozyurt/stepper_counter_swipe/blob/master/documents/green.gif?raw=true" width="300"/> <img src="https://github.com/burakozyurt/stepper_counter_swipe/blob/master/documents/red.gif?raw=true" width="300"/>

### Created

* [Ahmet Burak Ozyurt](https://github.com/burakozyurt)

## Usage example

```dart
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';
...
Container(
  padding: const EdgeInsets.all(8.0),
  child: StepperTouch(
    initialValue:0,
    speedTransitionLimitCount: 3, //Trigger count for fast counting
    onChanged: (int value) => print('new value $value'),
    firstIncrementDuration: Duration(milliseconds: 250), //Unit time before fast counting
    secondIncrementDuration: Duration(milliseconds: 100), //Unit time during fast counting
    direction: Axis.horizontal,
    dragButtonColor: Colors.blueAccent,
    withNaturalNumbers: false,
  ),
),
...
```
## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).
