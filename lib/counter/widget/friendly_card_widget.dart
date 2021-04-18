import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:friendly_cards/models/friendly_card.dart';
import 'package:nil/nil.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../extensions/context_extension.dart';

class FriendlyCardWidget extends StatelessWidget {
  const FriendlyCardWidget(
      {Key? key, required this.careCard, required this.color})
      : super(key: key);

  final FriendlyCard careCard;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CardShape(
      color: color,
      child: CardContent(
        careCard: careCard,
      ),
    );
  }
}

class CardShape extends StatelessWidget {
  const CardShape({
    Key? key,
    required this.color,
    this.child,
  }) : super(key: key);

  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          color: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            height: context.height * 0.65 >= 500 ? 500 : context.height * 0.65,
            width: getValueForScreenType<double>(
              context: context,
              mobile: constraints.maxWidth <= 320 ? 260 : 320,
              tablet: 375,
              desktop: 375,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: child ?? nil,
          ),
        );
      },
    );
  }
}

class CardContent extends StatelessWidget {
  const CardContent({
    Key? key,
    required this.careCard,
  }) : super(key: key);

  final FriendlyCard careCard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30.0,
        horizontal: 10.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 30),
          Text(
            careCard.title!.trim(),
            style: TextStyle(
                fontSize: context.width <= 320 ? 30 : 40,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: context.height * 0.1),
          Container(
            child: Text(
              careCard.body!.trim(),
              style: TextStyle(
                  fontSize: context.width <= 320
                      ? 14
                      : context.width >= 360
                          ? 18
                          : 16,
                  color: Colors.white),
              textAlign: TextAlign.left,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
