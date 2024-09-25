import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductSlider extends StatelessWidget {
  List<String> gambar;
  ProductSlider({super.key, required this.gambar});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 120.0),
      items: gambar.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.amber),
                child: Text(
                  'text $i',
                  style: TextStyle(fontSize: 16.0),
                ));
          },
        );
      }).toList(),
    );
  }
}
