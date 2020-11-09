import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// the concept of the widget inspired
/// from [Nikolay Kuchkarov](https://dribbble.com/shots/5639404-Stepper-XVIII).
/// i extended  the functionality to be more useful in real world applications
class StepperSwipe extends StatefulWidget {
  StepperSwipe({
    Key key,
    @required this.initialValue,
    this.withNaturalNumbers = false,
    this.withBackground = true,
    @required this.onChanged,
    this.direction = Axis.horizontal,
    this.withSpring = true,
    this.counterTextColor = Colors.white,
    this.dragButtonColor = const Color(0xFF9874f8),
    this.iconsColor = Colors.white,
    this.withPlusMinus = false,
    this.withPressed = false,
    this.firstIncrementDuration = const Duration(milliseconds: 250),
    this.secondIncrementDuration = const Duration(milliseconds: 250),
    this.speedTransitionLimitCount = 3,
    this.maxValue = 50,
    this.withFastCount = false,
    this.iconSize,
    @required this.stepperValue,
  }) : super(key: key);

  final Axis direction;

  final int initialValue;
  final bool withNaturalNumbers;
  final bool withBackground;
  int stepperValue;

  final Duration firstIncrementDuration;
  final Duration secondIncrementDuration;
  final int speedTransitionLimitCount;

  final ValueChanged<int> onChanged;

  final bool withSpring;
  final bool withPlusMinus;
  final bool withFastCount;
  final bool withPressed;
  final int maxValue;
  final double iconSize;

  final Color counterTextColor;
  final Color dragButtonColor;
  final Color iconsColor;

  @override
  _Stepper2State createState() => _Stepper2State();
}

class _Stepper2State extends State<StepperSwipe>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  int _value;
  double _startAnimationPosX;
  double _startAnimationPosY;
  bool isTimerEnable = true;
  bool isReadyToFastAnim = true;
  @override
  void initState() {
    super.initState();
    _value = widget.initialValue ?? 0;
    widget.stepperValue = _value;
    _controller =
        AnimationController(vsync: this, lowerBound: -0.5, upperBound: 0.5);
    _controller.value = 0.0;
    _controller.addListener(() {});

    if (widget.direction == Axis.horizontal) {
      _animation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(1.5, 0.0))
          .animate(_controller);
    } else {
      _animation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, 1.5))
          .animate(_controller);
    }

    print("widget.stepperValue ${widget.stepperValue}");
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.direction == Axis.horizontal) {
      _animation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(1.5, 0.0))
          .animate(_controller);
    } else {
      _animation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, 1.5))
          .animate(_controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: widget.direction == Axis.horizontal ? 210.0 : 90.0,
          height: widget.direction == Axis.horizontal ? 90.0 : 210.0,
          child: Material(
            type: MaterialType.canvas,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(60.0),
            color: widget.withBackground == true
                ? Colors.white.withOpacity(0.2)
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
                        ? IconButton(
                            disabledColor: Colors.white,
                            // splashColor: Colors.transparent,
                            // highlightColor: Colors.transparent,
                            onPressed: widget.withPressed
                                ? () {
                                    setState(() {
                                      if (widget.stepperValue > 0) {
                                        widget.stepperValue--;
                                        widget.onChanged(widget.stepperValue);
                                      }
                                    });
                                  }
                                : null,
                            icon: widget.withPlusMinus == false
                                ? Icon(Icons.keyboard_arrow_left)
                                : Icon(Icons.remove),
                            iconSize: widget.iconSize ?? 40.0,
                            color: widget.iconsColor)
                        : IconButton(
                            disabledColor: Colors.white,
                            // splashColor: Colors.transparent,
                            // highlightColor: Colors.transparent,
                            onPressed: widget.withPressed
                                ? () {
                                    setState(() {
                                      if (widget.stepperValue > 0) {
                                        widget.stepperValue--;
                                        widget.onChanged(widget.stepperValue);
                                      }
                                    });
                                  }
                                : null,
                            icon: Icon(
                              widget.withPlusMinus == false
                                  ? Icons.keyboard_arrow_down
                                  : Icons.remove,
                            ),
                            iconSize: widget.iconSize ?? 40.0,
                            color: widget.iconsColor),
                  ),
                  Positioned(
                    right: widget.direction == Axis.horizontal ? 10.0 : null,
                    top: widget.direction == Axis.horizontal ? null : 10.0,
                    child: widget.direction == Axis.horizontal
                        ? IconButton(
                            // splashColor: Colors.transparent,
                            // highlightColor: Colors.transparent,
                            disabledColor: Colors.white,
                            onPressed: widget.withPressed
                                ? () {
                                    setState(() {
                                      if (widget.stepperValue <
                                          widget.maxValue) {
                                        widget.stepperValue++;
                                        widget.onChanged(widget.stepperValue);
                                      }
                                    });
                                  }
                                : null,
                            icon: Icon(
                              widget.withPlusMinus == false
                                  ? Icons.keyboard_arrow_right
                                  : Icons.add,
                            ),
                            iconSize: widget.iconSize ?? 40.0,
                            color: widget.iconsColor)
                        : IconButton(
                            // splashColor: Colors.transparent,
                            // highlightColor: Colors.transparent,
                            disabledColor: Colors.white,
                            onPressed: widget.withPressed
                                ? () {
                                    setState(() {
                                      if (widget.stepperValue <
                                          widget.maxValue) {
                                        widget.stepperValue++;
                                        widget.onChanged(widget.stepperValue);
                                      }
                                    });
                                  }
                                : null,
                            icon: Icon(
                              widget.withPlusMinus == false
                                  ? Icons.keyboard_arrow_up
                                  : Icons.add,
                            ),
                            iconSize: widget.iconSize ?? 40.0,
                            color: widget.iconsColor),
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
                            '${widget.stepperValue}',
                            key: ValueKey<int>(widget.stepperValue),
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
    //print(_controller.value);
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

  fastCount() {
    if (isTimerEnable) {
      isTimerEnable = false;
      bool isHor = widget.direction == Axis.horizontal;
      Timer(Duration(milliseconds: 100), () {
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
            if (widget.withNaturalNumbers) {
              if (_controller.value <= -0.1923) {
                setState(() => isHor
                    ? widget.stepperValue >= 1
                        ? widget.stepperValue--
                        : widget.stepperValue = 0
                    : widget.stepperValue < widget.maxValue
                        ? widget.stepperValue++
                        : widget.stepperValue);
              } else if (_controller.value >= 0.1923) {
                setState(() => isHor
                    ? widget.stepperValue < widget.maxValue
                        ? widget.stepperValue++
                        : widget.stepperValue
                    : widget.stepperValue >= 1
                        ? widget.stepperValue--
                        : widget.stepperValue = 0);
              }
            } else {
              if (_controller.value <= -0.1923) {
                setState(() => isHor
                    ? widget.stepperValue--
                    : widget.stepperValue < widget.maxValue
                        ? widget.stepperValue++
                        : widget.stepperValue);
              } else if (_controller.value >= 0.1923) {
                setState(() => isHor
                    ? widget.stepperValue < widget.maxValue
                        ? widget.stepperValue++
                        : widget.stepperValue
                    : widget.stepperValue--);
              }
            }
          });
          Timer.periodic(widget.secondIncrementDuration, (timer) {
            if (isReadyToFastAnim == false) {
              timer.cancel();
              isReadyToFastAnim = true;
            }
            if (widget.withNaturalNumbers) {
              if (velocitLimit > widget.speedTransitionLimitCount) {
                if (_controller.value <= -0.1923) {
                  setState(() => isHor
                      ? widget.stepperValue >= 2
                          ? widget.stepperValue--
                          : widget.stepperValue = 0
                      : widget.stepperValue < widget.maxValue
                          ? widget.stepperValue++
                          : widget.stepperValue);
                } else if (_controller.value >= 0.1923) {
                  setState(() => isHor
                      ? widget.stepperValue < widget.maxValue
                          ? widget.stepperValue++
                          : widget.stepperValue
                      : widget.stepperValue >= 2
                          ? widget.stepperValue--
                          : widget.stepperValue = 0);
                }
              }
            } else {
              if (velocitLimit > widget.speedTransitionLimitCount) {
                if (_controller.value <= -0.1923) {
                  setState(() => isHor
                      ? widget.stepperValue--
                      : widget.stepperValue < widget.maxValue
                          ? widget.stepperValue++
                          : widget.stepperValue);
                } else if (_controller.value >= 0.1923) {
                  setState(() => isHor
                      ? widget.stepperValue < widget.maxValue
                          ? widget.stepperValue++
                          : widget.stepperValue
                      : widget.stepperValue--);
                }
              }
            }
          });
        }
      });
    }

    /*if(isfastCount == true){
      bool isHor = widget.direction == Axis.horizontal;
      bool changed = false;
      Future.
      setState(() => isHor ? widget.stepperValue-- : widget.stepperValue++);
      changed = true;
      }
    }*/
  }

  void _onPanEnd(DragEndDetails details) {
    _controller.stop();
    isReadyToFastAnim = false;
    isTimerEnable = true;
    bool isHor = widget.direction == Axis.horizontal;
    bool isChanged = false;
    if (widget.withNaturalNumbers) {
      if (_controller.value <= -0.1923) {
        _controller.value = -0.1923;
        setState(() => isHor
            ? widget.stepperValue >= 1
                ? widget.stepperValue--
                : 0
            : widget.stepperValue < widget.maxValue
                ? widget.stepperValue++
                : widget.stepperValue);
        isChanged = true;
      } else if (_controller.value >= 0.1923) {
        _controller.value = 0.1923;
        setState(() => isHor
            ? widget.stepperValue < widget.maxValue
                ? widget.stepperValue++
                : widget.stepperValue
            : widget.stepperValue >= 1
                ? widget.stepperValue--
                : 0);
        isChanged = true;
      }
    } else {
      if (_controller.value <= -0.1923) {
        _controller.value = -0.1923;
        setState(() => isHor
            ? widget.stepperValue--
            : widget.stepperValue < widget.maxValue
                ? widget.stepperValue++
                : widget.stepperValue);
        isChanged = true;
      } else if (_controller.value >= 0.1923) {
        _controller.value = 0.1923;
        setState(() => isHor
            ? widget.stepperValue < widget.maxValue
                ? widget.stepperValue++
                : widget.stepperValue
            : widget.stepperValue--);
        isChanged = true;
      }
    }
    if (widget.withSpring) {
      final SpringDescription _kDefaultSpring =
          new SpringDescription.withDampingRatio(
        mass: 0.9,
        stiffness: 250.0,
        ratio: 0.6,
      );
      if (widget.direction == Axis.horizontal) {
        _controller.animateWith(
            SpringSimulation(_kDefaultSpring, _startAnimationPosX, 0.0, 0.0));
      } else {
        _controller.animateWith(
            SpringSimulation(_kDefaultSpring, _startAnimationPosY, 0.0, 0.0));
      }
    } else {
      _controller.animateTo(0.0,
          curve: Curves.bounceOut, duration: Duration(milliseconds: 500));
    }

    if (isChanged && widget.onChanged != null) {
      widget.onChanged(widget.stepperValue);
    }
  }
}
