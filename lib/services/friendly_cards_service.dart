import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:friendly_cards/models/friendly_card.dart';
import 'package:friendly_cards/repositories/friendly_cards_repository.dart';

class FriendlyCardsService {
  final friendlyCardsRepository = FriendlyCardsRepository();

  Future<List<FriendlyCard>> getFriendlyCards() async {
    try {
      final rawString =
          await rootBundle.loadString('assets/friendly_cards.json');

      final data = (json.decode(rawString) as List)..shuffle();

      final friendlyCards = data.map((e) => FriendlyCard.fromJson(e)).toList();
      return friendlyCards;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
