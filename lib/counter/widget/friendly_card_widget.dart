import 'package:flutter/material.dart';
import 'package:friendly_cards/models/friendly_card.dart';

class FriendlyCardWidget extends StatelessWidget {
  const FriendlyCardWidget(
      {Key? key, required this.careCard, required this.color})
      : super(key: key);

  final FriendlyCard careCard;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Container(
        height: 450,
        width: 300,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              careCard.title as String,
              style: const TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            Text(
              careCard.body as String,
              style: const TextStyle(fontSize: 18, color: Colors.white),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
