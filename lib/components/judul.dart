import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Judul extends StatelessWidget {
  String nama;
  double pad;
  double ukuran;
  Judul(
      {super.key, required this.nama, required this.pad, required this.ukuran});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: pad),
        child: Text(nama, style: TextStyle(fontSize: ukuran)));
  }
}
