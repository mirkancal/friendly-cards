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

  late final List<Color> generatedColors;

  int currentIndex = 0;

  bool isRotation = false;
  bool isOpacity = false;
  bool isFirstTime = true;
  late Color backgroundColor = Colors.white;
  late final AnimationController rotationController;
  late final AnimationController opacityController;
  late final TweenSequence tweenRotation;
  late final Animation<double> transitionRotation;
  late final Animation<double> foregroundCardRotationAnimation;
  late final Animation<double> backgroundCardRotationAnimation;
  late final Animation<double> opacityAnimation;

  late final FriendlyCardsService friendlyCardsService;

  late final Future<List<SlidableAnimatedCard>> friendlyCards;

  late SlidableAnimatedCard currentCard;
  late List<SlidableAnimatedCard> loopedCards;

  List<Color> randomColorGenerator(int amount) {
    var shuffledColors = colors..shuffle();
    return List.generate(amount, (index) => shuffledColors[index % 7]).toList();
  }

  @override
  void initState() {
    friendlyCardsService = FriendlyCardsService();
    friendlyCards = friendlyCardsService.getFriendlyCards().then((cards) {
      generatedColors = randomColorGenerator(cards.length);
      backgroundColor = generatedColors[0];

      return List.generate(
        cards.length,
        (index) {
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

    rotationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    opacityController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));

    opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: opacityController, curve: Curves.easeIn));

    transitionRotation = Tween<double>(
      end: pi / 30,
      begin: 0,
    ).animate(CurvedAnimation(
        parent: rotationController, curve: const Interval(0.2, 1)));

    foregroundCardRotationAnimation = Tween<double>(
      begin: pi / 30,
      end: 0,
    ).animate(CurvedAnimation(
        parent: rotationController, curve: const Interval(0.2, 1)));

    backgroundCardRotationAnimation = Tween<double>(
      begin: pi / 30,
      end: 0,
    ).animate(CurvedAnimation(
        parent: rotationController, curve: const Interval(0.2, 1)));

    rotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isRotation = false;
        rotationController.reverse();
      } else if (status == AnimationStatus.forward) {
        isRotation = true;
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
      if (currentIndex + 1 < cards.length) {
        currentIndex += 1;
      } else {
        currentIndex = 0;
      }

      currentCard = cards[currentIndex];
      backgroundColor = generatedColors[currentIndex];

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
        future: friendlyCards.then((value) => cards = value).whenComplete(() {
          return Future.delayed(const Duration(milliseconds: 500));
        }),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            if (isFirstTime) {
              currentCard = cards.first;
              rotationController.forward();
              isFirstTime = false;
            }

            return AnimatedBuilder(
              animation: rotationController,
              builder: (BuildContext context, Widget? child) {
                return Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Transform.rotate(
                        angle: backgroundCardRotationAnimation.value,
                        child: const CardShape(
                          color: Color(0xFF705F67),
                        ),
                      ),
                    ),
                    Positioned(
                      child: cards.isNotEmpty
                          ? Transform.rotate(
                              angle: isRotation
                                  ? foregroundCardRotationAnimation.value
                                  : 0,
                              child: Opacity(
                                  opacity:
                                      isOpacity ? opacityAnimation.value : 1,
                                  child: currentCard))
                          : Container(),
                    )
                  ],
                );
              },
            );
          }

          return Center(
            child: CardShape(
              color: const Color(0xFF705F67),
              child: Center(
                child: LoadingJumpingLine.circle(
                  size: 60,
                  duration: const Duration(milliseconds: 400),
                  backgroundColor: colors[0],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
