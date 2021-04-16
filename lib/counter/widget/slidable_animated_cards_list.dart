import 'dart:math';

import 'package:flutter/material.dart';
import 'package:friendly_cards/color_constants.dart';
import 'package:friendly_cards/counter/widget/slidable_animated_card.dart';
import 'package:friendly_cards/models/friendly_card.dart';

import 'friendly_card_widget.dart';

class SlidableAnimatedCardsList extends StatefulWidget {
  const SlidableAnimatedCardsList();

  @override
  _SlidableAnimatedCardsListState createState() =>
      _SlidableAnimatedCardsListState();
}

class _SlidableAnimatedCardsListState extends State<SlidableAnimatedCardsList>
    with TickerProviderStateMixin {
  late final List<SlidableAnimatedCard> cards = List.generate(
    10,
    (index) {
      backgroundColor = generatedColors[0];
      return SlidableAnimatedCard(
        removeCard: _removeCard,
        child: FriendlyCardWidget(
          careCard: FriendlyCard(
              color: generatedColors[index].withOpacity(1),
              content: 'This is an example content',
              title: 'Example Title $index'),
        ),
      );
    },
  );

  late final generatedColors = randomColorGenerator(10);

  int colorIndex = 0;

  late final AnimationController rotationController;
  late final AnimationController opacityController;
  late final TweenSequence tweenRotation;
  late final Animation<double> rotationAnimation;
  late final Animation<double> opacityAnimation;
  bool isRotation = false;
  bool isOpacity = false;

  Color backgroundColor = Colors.white;

  List<Color> randomColorGenerator(int amount) {
    return List.generate(amount, (index) => friendlyCardColorList[index % 7])
        .toList();
  }

  @override
  void initState() {
    rotationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    opacityController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
        parent: opacityController, curve: const Interval(0.4, 1)));

    rotationAnimation = Tween<double>(
      begin: 0,
      end: pi / 30,
    ).animate(CurvedAnimation(
        parent: rotationController, curve: const Interval(0.2, 1)));

    rotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isRotation = true;
        rotationController.reverse();
      } else if (status == AnimationStatus.forward) {
        isRotation = false;
      }
    });

    opacityController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isOpacity = true;
      } else if (status == AnimationStatus.completed) {
        isOpacity = false;
        opacityController.reverse();
      }
    });
    super.initState();
  }

  void _removeCard() {
    setState(() {
      cards.removeAt(0);
      colorIndex += 1;

      backgroundColor = generatedColors[colorIndex % 10];
      rotationController.forward();
      opacityController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor.withOpacity(0.3),
      body: AnimatedBuilder(
        animation: rotationController,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: rotationAnimation.value,
                  child: Card(
                    color: const Color(0xFF705F67),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    child: Container(
                      height: 300,
                      width: 200,
                    ),
                  ),
                ),
              ),
              Positioned(
                child: cards.isNotEmpty
                    ? Transform.rotate(
                        angle: rotationAnimation.value,
                        child: Opacity(
                            opacity: isOpacity ? opacityAnimation.value : 1,
                            child: cards.first))
                    : Container(),
              )
            ],
          );
        },
      ),
    );
  }
}
