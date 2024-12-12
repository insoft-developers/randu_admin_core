import 'package:buzz/components/input_search.dart';
import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/shimmer_list.dart';
import 'package:buzz/components/spasi.dart';
import 'package:buzz/expenses/category/add/index.dart';
import 'package:buzz/expenses/category/edit/index.dart';
import 'package:buzz/expenses/category/expense_category_controller.dart';

import 'package:buzz/widgets/comuntitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseCategory extends StatefulWidget {
  const ExpenseCategory({super.key});

  @override
  State<ExpenseCategory> createState() => _ExpenseCategoryState();
}

class _ExpenseCategoryState extends State<ExpenseCategory> {
  final TextEditingController _search = TextEditingController();
  final ExpenseCategoryController _controller =
      Get.put(ExpenseCategoryController());

  @override
  void initState() {
    _controller.getCategoryList("");
    super.initState();
  }

  Future<void> _pullRefresh() async {
    _controller.getCategoryList("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: Column(
          children: [
            ComunTitle(title: 'Kategori \nPengeluaran', path: "Expenses"),
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
                      code: "adjustment-input-category"),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ExpenseCategoryAdd())
                        ?.then((value) => _controller.getCategoryList(""));
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
                  () => _controller.loading.value
                      ? ShimmerList(tinggi: 110, jumlah: 10, pad: 0)
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: _controller.categoryList.length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: const EdgeInsets.only(bottom: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            _controller.categoryList[index]
                                                    ['name']
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        Jarak(tinggi: 5),
                                      ],
                                    ),
                                    Jarak(tinggi: 10),
                                    _controller
                                                .categoryList[index][
                                                    'md_expense_category_product']
                                                .length ==
                                            0
                                        ? const SizedBox()
                                        : Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              border: Border.all(
                                                  color: Colors.grey.shade300),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: ExpansionTile(
                                              title: Text("Produk List",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              82,
                                                      child: ListView.builder(
                                                          physics:
                                                              const ScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount: _controller
                                                              .categoryList[
                                                                  index][
                                                                  'md_expense_category_product']
                                                              .length,
                                                          itemBuilder: (context,
                                                              index2) {
                                                            return Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          5),
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    child: Text(
                                                                      _controller
                                                                          .categoryList[
                                                                              index]
                                                                              [
                                                                              'md_expense_category_product']
                                                                              [
                                                                              index2]
                                                                              [
                                                                              'md_product']
                                                                              [
                                                                              'name']
                                                                          .toString(),
                                                                    ),
                                                                  ),
                                                                  Jarak(
                                                                      tinggi:
                                                                          5),
                                                                  Divider(
                                                                    color: Colors
                                                                            .grey[
                                                                        400],
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                    Jarak(tinggi: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(() => ExpenseCategoryEdit(
                                                    dataList: _controller
                                                        .categoryList[index]))!
                                                .then((value) => _controller
                                                    .getCategoryList(""));
                                          },
                                          child: Container(
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
                                        ),
                                        Spasi(lebar: 15),
                                        GestureDetector(
                                          onTap: () {
                                            _showAlertDialog(
                                                context,
                                                _controller.categoryList[index]
                                                    ['id'],
                                                _controller.categoryList[index]
                                                        ['name']
                                                    .toString());
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                    color: Colors.red),
                                                color: Colors.red.shade200),
                                            child: Icon(
                                              Icons.delete,
                                              size: 15,
                                              color: Colors.white,
                                            ),
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
      ),
    );
  }
}

void _showAlertDialog(
    BuildContext context, int categoryId, String categoryName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Hapus Kategori'),
        content: Text(
            "Apakah anda yakin ingin menghapus kategori [ ${categoryName} ] ?"),
        actions: <Widget>[
          TextButton(
            child: const Text('Batal'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Hapus'),
            onPressed: () {
              ExpenseCategoryController _controller =
                  Get.put(ExpenseCategoryController());
              _controller.categoryDelete(categoryId);
              Get.back();
            },
          ),
        ],
      );
    },
  );
}
