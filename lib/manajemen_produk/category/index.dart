import 'package:buzz/components/input_search.dart';
import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/shimmer_list.dart';
import 'package:buzz/components/spasi.dart';
import 'package:buzz/manajemen_produk/category/add/index.dart';
import 'package:buzz/manajemen_produk/category/product_category_controller.dart';
import 'package:buzz/utils/contstant.dart';
import 'package:buzz/widgets/comuntitle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCategory extends StatefulWidget {
  const ProductCategory({super.key});

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  final TextEditingController _search = TextEditingController();
  final ProductCategoryController _productCategoryController =
      Get.put(ProductCategoryController());

  @override
  void initState() {
    _productCategoryController.getCategoryList("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ComunTitle(title: 'Daftar Kategori', path: "Manajemen Produk"),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 40,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InputSearch(
                    hint: "Cari nama kategori",
                    textInputType: TextInputType.text,
                    iconData: Icons.search,
                    textEditingController: _search,
                    code: "product-category"),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => ProductCategoryAdd());
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.green),
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Jarak(tinggi: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Obx(
                () => _productCategoryController.loading.value
                    ? ShimmerList(tinggi: 110, jumlah: 10, pad: 0)
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            _productCategoryController.categoryList.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          width: 40,
                                          height: 40,
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.blue),
                                          child: _productCategoryController
                                                      .categoryList[index]
                                                          ['image']
                                                      .toString()
                                                      .isEmpty ||
                                                  _productCategoryController
                                                              .categoryList[
                                                          index]['image'] ==
                                                      null
                                              ? Image.asset(
                                                  "assets/product_placeholder.png")
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    imageUrl: Constant
                                                            .PRODUCT_CATEGORY_IMAGE +
                                                        _productCategoryController
                                                            .categoryList[index]
                                                                ['image']
                                                            .toString(),
                                                  ),
                                                )),
                                      Spasi(lebar: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              _productCategoryController
                                                  .categoryList[index]['code']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Jarak(tinggi: 5),
                                          Text(
                                              _productCategoryController
                                                  .categoryList[index]['name']
                                                  .toString(),
                                              style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Jarak(tinggi: 10),
                                  _productCategoryController.categoryList[index]
                                                  ['description']
                                              .toString()
                                              .isEmpty ||
                                          _productCategoryController
                                                      .categoryList[index]
                                                  ['description'] ==
                                              null
                                      ? const SizedBox()
                                      : Text(
                                          _productCategoryController
                                              .categoryList[index]
                                                  ['description']
                                              .toString(),
                                          style: TextStyle(color: Colors.grey)),
                                  Jarak(tinggi: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.orange),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.orange.shade200),
                                        child: Icon(
                                          Icons.edit,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Spasi(lebar: 15),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border:
                                                Border.all(color: Colors.red),
                                            color: Colors.red.shade200),
                                        child: Icon(
                                          Icons.delete,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Spasi(lebar: 5),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey[400],
                                  )
                                ],
                              ));
                        }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
