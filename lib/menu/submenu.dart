import 'package:buzz/components/input_search.dart';
import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/shimmer_list.dart';
import 'package:buzz/components/spasi.dart';
import 'package:buzz/new_appbar.dart';
import 'package:buzz/pembelian/beli_produk_jadi/add/beli_produk_add.dart';
import 'package:buzz/pembelian/beli_produk_jadi/beli_produk_jadi_controller.dart';
import 'package:buzz/pembelian/manufacture/product_manufacture_controller.dart';
import 'package:buzz/utils/helper.dart';

import 'package:buzz/widgets/comuntitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubMenu extends StatefulWidget {
  const SubMenu({super.key});

  @override
  State<SubMenu> createState() => _SubMenuState();
}

class _SubMenuState extends State<SubMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewAppBar(),
      body: Column(
        children: [
          ComunTitle(
              title: 'Transaksi Buat \nProduk', path: "Pembelian & Produksi"),
        ],
      ),
    );
  }
}
