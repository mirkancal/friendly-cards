import 'package:flutter/material.dart';
import 'package:friendly_cards/counter/widget/slidable_animated_cards.dart';

const imgUrl =
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1300&q=80';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> items = [Image.network(imgUrl)];

  @override
  Widget build(BuildContext context) {
    return SlidableAnimatedCards();
  }
}
