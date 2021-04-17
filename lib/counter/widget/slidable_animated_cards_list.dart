import 'dart:math';

import 'package:flutter/material.dart';
import 'package:friendly_cards/color_constants.dart';
import 'package:friendly_cards/counter/widget/slidable_animated_card.dart';
import 'package:friendly_cards/models/friendly_card.dart';
import 'package:friendly_cards/services/friendly_cards_service.dart';
import 'package:loading_animations/loading_animations.dart';
import '../../extensions/context_extension.dart';
import 'friendly_card_widget.dart';

class SlidableAnimatedCardsList extends StatefulWidget {
  const SlidableAnimatedCardsList();

  @override
  _SlidableAnimatedCardsListState createState() =>
      _SlidableAnimatedCardsListState();
}

class _SlidableAnimatedCardsListState extends State<SlidableAnimatedCardsList>
    with TickerProviderStateMixin {
  late List<SlidableAnimatedCard> cards;

  late final generatedColors = randomColorGenerator(10);

  int colorIndex = 0;

  bool isRotation = false;
  bool isOpacity = false;

  late Color backgroundColor;
  late final AnimationController rotationController;
  late final AnimationController opacityController;
  late final TweenSequence tweenRotation;
  late final Animation<double> rotationAnimation;
  late final Animation<double> opacityAnimation;

  late final FriendlyCardsService friendlyCardsService;

  late final Future<List<SlidableAnimatedCard>> friendlyCards;

  List<Color> randomColorGenerator(int amount) {
    return List.generate(amount, (index) => friendlyCardColorList[index % 7])
        .toList();
  }

  @override
  void initState() {
    friendlyCardsService = FriendlyCardsService();
    friendlyCards = friendlyCardsService.getFriendlyCards().then((cards) {
      return List.generate(
        cards.length,
        (index) {
          backgroundColor = generatedColors[0];
          return SlidableAnimatedCard(
            removeCard: _removeCard,
            child: FriendlyCardWidget(
              color: generatedColors[index].withOpacity(1),
              careCard: FriendlyCard(
                  body: cards[index].body, title: cards[index].title),
            ),
          );
        },
      ).toList();
    });

    backgroundColor = generatedColors[0];
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
  void dispose() {
    rotationController.dispose();
    opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor.withOpacity(0.3),
      body: FutureBuilder<List<SlidableAnimatedCard>>(
        future: friendlyCards.then((value) => cards = value).whenComplete(
            () => Future.delayed(const Duration(milliseconds: 500))),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return AnimatedBuilder(
              animation: rotationController,
              builder: (BuildContext context, Widget? child) {
                return Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Transform.rotate(
                        angle: rotationAnimation.value,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Card(
                            color: const Color(0xFF705F67),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            child: Container(
                              height: context.currentSize.height > 700
                                  ? context.currentSize.height > 800
                                      ? context.currentSize.height > 850
                                          ? 450
                                          : 400
                                      : 400
                                  : context.dynamicHeight(0.65),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: cards.isNotEmpty
                          ? Transform.rotate(
                              angle: rotationAnimation.value,
                              child: Opacity(
                                  opacity:
                                      isOpacity ? opacityAnimation.value : 1,
                                  child: cards.first))
                          : Container(),
                    )
                  ],
                );
              },
            );
          }

          return Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Card(
                color: const Color(0xFF705F67),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                child: Container(
                  height: context.currentSize.height > 700
                      ? context.currentSize.height > 800
                          ? context.currentSize.height > 850
                              ? 450
                              : 400
                          : 400
                      : context.dynamicHeight(0.65),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Center(
                    child: LoadingJumpingLine.square(
                      size: 60,
                      duration: const Duration(milliseconds: 600),
                      backgroundColor: friendlyCardColorList[0],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
