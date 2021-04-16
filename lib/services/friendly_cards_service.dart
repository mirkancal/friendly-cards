import 'package:friendly_cards/models/friendly_card.dart';
import 'package:friendly_cards/repositories/friendly_cards_repository.dart';

class FriendlyCardsService {
  final friendlyCardsRepository = FriendlyCardsRepository();

  Future<List<FriendlyCard>> getFriendlyCards() async {
    try {
      final response = await friendlyCardsRepository.getFriendlyCards();
      final friendlyCards = (response?.data as List)
          .map((e) => FriendlyCard.fromJson(e))
          .toList();
      return friendlyCards;
    } catch (e) {
      return [];
      print(e);
    }
  }
}
