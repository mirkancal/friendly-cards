import 'package:flutter/material.dart';
import 'package:friendly_cards/models/friendly_card.dart';

class FriendlyCardWidget extends StatelessWidget {
  const FriendlyCardWidget({Key? key, required this.careCard})
      : super(key: key);

  final FriendlyCard careCard;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: careCard.color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Container(
        height: 300,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(careCard.title),
            Text(careCard.content),
          ],
        ),
      ),
    );
  }
}
