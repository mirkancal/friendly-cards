import 'dart:math';

import 'package:flutter/material.dart';
import 'package:friendly_cards/counter/widget/slidable_animated_card.dart';
import 'package:friendly_cards/models/friendly_card.dart';

import 'friendly_card_widget.dart';

class SlidableAnimatedCardsList extends StatefulWidget {
  const SlidableAnimatedCardsList();

  @override
  _SlidableAnimatedCardsListState createState() =>
      _SlidableAnimatedCardsListState();
}

class _SlidableAnimatedCardsListState extends State<SlidableAnimatedCardsList> {
  late final List<SlidableAnimatedCard> cards;

  @override
  void initState() {
    cards = List.generate(
      10,
      (index) => SlidableAnimatedCard(
        removeCard: _removeCard,
        child: FriendlyCardWidget(
          careCard: FriendlyCard(
              color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1),
              content: 'This is an example content',
              title: 'Example Title $index'),
        ),
      ),
    );

    super.initState();
  }

  void _removeCard() {
    setState(() {
      cards.removeAt(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Transform.rotate(
              angle: pi / 30,
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
            child: cards.isNotEmpty ? cards.first : Container(),
          ),
        ],
      ),
    );
  }
}
