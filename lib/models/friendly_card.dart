class FriendlyCard {
  FriendlyCard({this.title, this.body});

  FriendlyCard.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
  }
  String? body;
  String? title;
}
