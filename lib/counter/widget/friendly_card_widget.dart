import 'package:flutter/material.dart';
import 'package:friendly_cards/models/friendly_card.dart';
import '../../extensions/context_extension.dart';

class FriendlyCardWidget extends StatelessWidget {
  const FriendlyCardWidget(
      {Key? key, required this.careCard, required this.color})
      : super(key: key);

  final FriendlyCard careCard;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Container(
          height: context.currentSize.height > 700
              ? context.currentSize.height > 800
                  ? context.currentSize.height > 850
                      ? 450
                      : 400
                  : 400
              : context.dynamicHeight(0.65),
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                (careCard.title as String).toString().trim(),
                style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              Text(
                (careCard.body as String).toString().trim(),
                style: const TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
