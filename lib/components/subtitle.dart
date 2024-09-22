import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Subtitle extends StatelessWidget {
  String text;

  Subtitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(text, style: TextStyle(color: Colors.grey.shade400)));
  }
}
