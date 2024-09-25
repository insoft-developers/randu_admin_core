import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomNote extends StatelessWidget {
  String text;
  double pad;
  BottomNote({super.key, required this.text, required this.pad});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: pad),
        child: Text(text,
            style: TextStyle(color: Colors.red.shade300, fontSize: 13)));
  }
}
