// ignore_for_file: deprecated_member_use

import 'package:buzz/widgets/comuntitle.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ComunTitle(title: 'Daftar Produk', path: "Manajemen Produk"),
    );
  }
}
