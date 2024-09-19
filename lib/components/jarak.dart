import 'package:flutter/material.dart';

class Jarak extends StatelessWidget {
  double tinggi;
  Jarak({Key? key, required this.tinggi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: tinggi,
    );
  }
}
