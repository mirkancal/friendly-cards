import 'package:auto_size_text/auto_size_text.dart';
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
    final dynamicHeight = context.currentSize.height > 700
        ? context.currentSize.height > 800
            ? context.currentSize.height > 850
                ? 450
                : 400
            : 400
        : context.dynamicHeight(0.65);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Container(
          height: dynamicHeight.toDouble(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Spacer(
                flex: 2,
              ),
              Container(
                height: dynamicHeight.toDouble() * .5,
                child: AutoSizeText(
                  (careCard.title as String).toString().trim(),
                  style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  softWrap: true,
                  wrapWords: true,
                  maxFontSize: 50,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: dynamicHeight.toDouble() / 3,
                width: context.dynamicWidth(0.7),
                child: Text(
                  (careCard.body as String).toString().trim(),
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.left,
                  softWrap: true,
                ),
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
