import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import '../../extensions/context_extension.dart';
import 'dart:math';

class SlidableAnimatedCards extends StatefulWidget {
  @override
  _SlidableAnimatedCardsState createState() => _SlidableAnimatedCardsState();
}

class _SlidableAnimatedCardsState extends State<SlidableAnimatedCards>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController.unbounded(vsync: this);
    super.initState();
  }

  double direction = 0.0;
  Offset dragStartOffset = const Offset(0, 0);
  Offset dragUpdateOffset = const Offset(0, 0);

  bool _swipeMeetsEscapeVelocity(Offset dragOffset, Velocity velocity) {
    return dragOffset.distance + velocity.pixelsPerSecond.distance >
            3 * context.currentSize.width / 4 &&
        velocity.pixelsPerSecond.distance > 400;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.animateBack(0.0,
                  duration: const Duration(milliseconds: 400));
            },
          )
        ],
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) => Center(
          child: Transform.translate(
            offset: Offset.fromDirection(direction, controller.value),
            child: Transform.rotate(
              angle: rotateCardByOffset(
                  Offset.fromDirection(direction, controller.value)),
              child: GestureDetector(
                onPanStart: (details) {
                  dragStartOffset = details.globalPosition;
                },
                onPanUpdate: (details) {
                  dragUpdateOffset = details.globalPosition;
                  var userDragOffset = dragUpdateOffset - dragStartOffset;
                  direction = userDragOffset.direction;
                  controller.value = userDragOffset.distance;
                },
                onPanEnd: (details) {
                  var userDragOffset = dragUpdateOffset - dragStartOffset;
                  if (_swipeMeetsEscapeVelocity(
                      userDragOffset, details.velocity)) {
                    var frictionSimulation = FrictionSimulation(
                        0.9,
                        controller.value,
                        details.velocity.pixelsPerSecond.distance);
                    controller.animateWith(frictionSimulation);
                  } else {
                    var springDescription = const SpringDescription(
                        mass: 5, stiffness: 5, damping: 5);
                    var springSimulation = SpringSimulation(
                        springDescription,
                        controller.value,
                        0,
                        details.velocity.pixelsPerSecond.distance);

                    controller.animateWith(springSimulation);
                  }
                },
                child: Container(
                  height: 300,
                  width: 200,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

double rotateCardByOffset(Offset offset) {
  print('Offset.dx: ${offset.dx},  Offset.dy: ${offset.dy}');
  if (offset.dy > 0 && offset.dx > 0) {
    var rotationAngle = offset.dx / 100 > 1 ? 1 : offset.dx / 100;
    return -(pi * 1 / 10) * rotationAngle;
  } else if (offset.dy > 0 && offset.dx < 0) {
    var rotationAngle = offset.dx / 100 > 1 ? 1 : offset.dx / 100;
    return -(pi * 1 / 10) * rotationAngle;
  } else if (offset.dy < 0 && offset.dx < 0) {
    var rotationAngle = offset.dx / 100 > 1 ? 1 : offset.dx / 100;
    return -(pi * 1 / 10) * rotationAngle;
  } else if (offset.dy < 0 && offset.dx > 0) {
    var rotationAngle = offset.dx / 100 > 1 ? 1 : offset.dx / 100;
    return -(pi * 1 / 10) * rotationAngle;
  }

  return pi;
}

class AnimatedStackedList extends StatefulWidget {
  @override
  _AnimatedStackedListState createState() => _AnimatedStackedListState();
}

class _AnimatedStackedListState extends State<AnimatedStackedList> {
  @override
  Widget build(BuildContext context) {
    return Stack();
  }
}
