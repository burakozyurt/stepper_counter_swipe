import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// the concept of the widget inspired
/// from [Nikolay Kuchkarov](https://dribbble.com/shots/5639404-Stepper-XVIII).
/// i extended  the functionality to be more useful in real world applications
class StepperSwipe extends StatefulWidget {
  const StepperSwipe({
    Key? key,
    required this.initialValue,
    @Deprecated('use minValue:0 instead')
    this.withNaturalNumbers = false,
    this.withBackground = true,
    required this.onChanged,
    this.direction = Axis.horizontal,
    this.withSpring = true,
    this.counterTextColor = Colors.white,
    this.dragButtonColor = const Color(0xFF9874f8),
    this.iconsColor = Colors.white,
    this.withPlusMinus = false,
    this.firstIncrementDuration = const Duration(milliseconds: 250),
    this.secondIncrementDuration = const Duration(milliseconds: 100),
    this.speedTransitionLimitCount = 3,
    this.maxValue = 50,
    this.minValue = -50,
    this.withFastCount = false,
    this.step = 1,
  }) : super(key: key);

  final Axis direction;

  final int initialValue;
  // ignore: deprecated_member_use_from_same_package
  final bool withNaturalNumbers;
  final bool withBackground;

  final Duration firstIncrementDuration;
  final Duration secondIncrementDuration;
  final int speedTransitionLimitCount;

  final ValueChanged<int> onChanged;

  final bool withSpring;
  final bool withPlusMinus;
  final bool withFastCount;
  final int maxValue;
  final int minValue;
  final int step;

  final Color counterTextColor;
  final Color dragButtonColor;
  final Color iconsColor;

  @override
  _Stepper2State createState() => _Stepper2State();
}

class _Stepper2State extends State<StepperSwipe>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late int _value;
  late int _effectiveMinValue;
  double _startAnimationPosX = 0.0;
  double _startAnimationPosY = 0.0;
  bool isTimerEnable = true;
  bool isReadyToFastAnim = true;

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use_from_same_package
    _effectiveMinValue = widget.withNaturalNumbers ? 0 : widget.minValue;
    _value = widget.initialValue;
    _controller =
        AnimationController(vsync: this, lowerBound: -0.5, upperBound: 0.5);
    _controller.value = 0.0;
    _controller.addListener(() {});

    _updateAnimation();
  }

  void _updateAnimation() {
    if (widget.direction == Axis.horizontal) {
      _animation = Tween<Offset>(begin: Offset.zero, end: const Offset(1.5, 0.0))
          .animate(_controller);
    } else {
      _animation = Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, 1.5))
          .animate(_controller);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: widget.direction == Axis.horizontal ? 210.0 : 90.0,
          height: widget.direction == Axis.horizontal ? 90.0 : 210.0,
          child: Material(
            type: MaterialType.canvas,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(60.0),
            color: widget.withBackground == true
                ? Colors.white.withAlpha(51)
                : Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    left: widget.direction == Axis.horizontal ? 10.0 : null,
                    bottom: widget.direction == Axis.horizontal ? null : 10.0,
                    child: widget.direction == Axis.horizontal
                        ? Icon(widget.withPlusMinus == false ? Icons.keyboard_arrow_left : Icons.remove, size: 40.0, color: widget.iconsColor)
                        : Icon(widget.withPlusMinus == false ? Icons.keyboard_arrow_down : Icons.remove, size: 40.0, color: widget.iconsColor),
                  ),
                  Positioned(
                    right: widget.direction == Axis.horizontal ? 10.0 : null,
                    top: widget.direction == Axis.horizontal ? null : 10.0,
                    child: widget.direction == Axis.horizontal
                        ? Icon(widget.withPlusMinus == false ? Icons.keyboard_arrow_right : Icons.add, size: 40.0, color: widget.iconsColor)
                        : Icon(widget.withPlusMinus == false ? Icons.keyboard_arrow_up : Icons.add, size: 40.0, color: widget.iconsColor),
                  ),
                  GestureDetector(
                    onHorizontalDragStart: _onPanStart,
                    onHorizontalDragUpdate: _onPanUpdate,
                    onHorizontalDragEnd: _onPanEnd,
                    child: SlideTransition(
                      position: _animation,
                      child: Material(
                        color: widget.dragButtonColor,
                        shape: const CircleBorder(),
                        elevation: 5.0,
                        child: Center(
                          child: Text(
                            '$_value',
                            key: ValueKey<int>(_value),
                            style: TextStyle(
                                color: widget.counterTextColor, fontSize: 36.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  double offsetFromGlobalPos(Offset globalPosition) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset local = box.globalToLocal(globalPosition);
    _startAnimationPosX = ((local.dx * 0.75) / box.size.width) - 0.4;
    _startAnimationPosY = ((local.dy * 0.75) / box.size.height) - 0.4;
    if (widget.direction == Axis.horizontal) {
      return ((local.dx * 0.75) / box.size.width) - 0.4;
    } else {
      return ((local.dy * 0.75) / box.size.height) - 0.4;
    }
  }

  void _onPanStart(DragStartDetails details) {
    _controller.stop();
    _controller.value = offsetFromGlobalPos(details.globalPosition);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    double value = offsetFromGlobalPos(details.globalPosition);
    isReadyToFastAnim = true;
    if (value <= -0.1923) {
      _controller.value = -0.1923;
      _startAnimationPosX = -0.1923;
      _startAnimationPosY = -0.1923;
      if (widget.withFastCount) fastCount();
    } else if (value >= 0.1923) {
      _controller.value = 0.1923;
      _startAnimationPosX = 0.1923;
      _startAnimationPosY = 0.1923;
      if (widget.withFastCount) fastCount();
    } else {
      isReadyToFastAnim = false;
      _controller.value = offsetFromGlobalPos(details.globalPosition);
    }
  }

  void _decrement() {
    if (_value > _effectiveMinValue) {
      setState(() => _value = (_value - widget.step).clamp(_effectiveMinValue, widget.maxValue));
    }
  }

  void _increment() {
    if (_value < widget.maxValue) {
      setState(() => _value = (_value + widget.step).clamp(_effectiveMinValue, widget.maxValue));
    }
  }

  void fastCount() {
    if (isTimerEnable) {
      isTimerEnable = false;
      bool isHor = widget.direction == Axis.horizontal;
      Timer(const Duration(milliseconds: 100), () {
        if (isReadyToFastAnim) {
          int velocitLimit = 0;
          Timer.periodic(widget.firstIncrementDuration, (timer) {
            if (isReadyToFastAnim == false) {
              timer.cancel();
              isReadyToFastAnim = true;
            }
            if (velocitLimit > widget.speedTransitionLimitCount) {
              timer.cancel();
            }
            velocitLimit++;
            if (_controller.value <= -0.1923) {
              isHor ? _decrement() : _increment();
            } else if (_controller.value >= 0.1923) {
              isHor ? _increment() : _decrement();
            }
          });
          Timer.periodic(widget.secondIncrementDuration, (timer) {
            if (isReadyToFastAnim == false) {
              timer.cancel();
              isReadyToFastAnim = true;
            }
            if (velocitLimit > widget.speedTransitionLimitCount) {
              if (_controller.value <= -0.1923) {
                isHor ? _decrement() : _increment();
              } else if (_controller.value >= 0.1923) {
                isHor ? _increment() : _decrement();
              }
            }
          });
        }
      });
    }
  }

  void _onPanEnd(DragEndDetails details) {
    _controller.stop();
    isReadyToFastAnim = false;
    isTimerEnable = true;
    bool isHor = widget.direction == Axis.horizontal;
    bool isChanged = false;
    if (_controller.value <= -0.1923) {
      _controller.value = -0.1923;
      if (isHor) {
        if (_value > _effectiveMinValue) { _decrement(); isChanged = true; }
      } else {
        if (_value < widget.maxValue) { _increment(); isChanged = true; }
      }
    } else if (_controller.value >= 0.1923) {
      _controller.value = 0.1923;
      if (isHor) {
        if (_value < widget.maxValue) { _increment(); isChanged = true; }
      } else {
        if (_value > _effectiveMinValue) { _decrement(); isChanged = true; }
      }
    }
    if (widget.withSpring) {
      final SpringDescription kDefaultSpring = SpringDescription.withDampingRatio(
        mass: 0.9,
        stiffness: 250.0,
        ratio: 0.6,
      );
      if (widget.direction == Axis.horizontal) {
        _controller.animateWith(
            SpringSimulation(kDefaultSpring, _startAnimationPosX, 0.0, 0.0));
      } else {
        _controller.animateWith(
            SpringSimulation(kDefaultSpring, _startAnimationPosY, 0.0, 0.0));
      }
    } else {
      _controller.animateTo(0.0,
          curve: Curves.bounceOut, duration: const Duration(milliseconds: 500));
    }

    if (isChanged) {
      widget.onChanged(_value);
    }
  }
}
