import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:friendly_cards/utils/handle_errors.dart';

class FriendlyCardsRepository {
  static final mainUrl = 'https://jsonblob.com';

  static const oauthApplicationId = '9b5b3cd7-9ee1-11eb-a08e-fde22542fbdc';

  static final baseUrl = '$mainUrl/api/jsonBlob/$oauthApplicationId';

  final client = Dio()
    ..options.baseUrl = baseUrl
    ..options.contentType = 'application/json';

  Future<Response?> getFriendlyCards() async {
    try {
      final response = await client.get('');
      return response;
    } catch (e) {
      handleError(e);
    }
  }
}
