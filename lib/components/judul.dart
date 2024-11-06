import 'package:buzz/components/spasi.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Judul extends StatelessWidget {
  String nama;
  double pad;
  double ukuran;
  int mandatory;
  Judul(
      {super.key,
      required this.nama,
      required this.pad,
      required this.ukuran,
      required this.mandatory});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: pad),
        padding: const EdgeInsets.only(left: 0),
        child: Row(
          children: [
            Text(nama, style: TextStyle(fontSize: 14)),
            Spasi(lebar: 8),
            mandatory == 1
                ? Text("*",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green))
                : Text("( Opsional )",
                    style: TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ));
  }
}
