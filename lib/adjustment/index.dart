import 'package:buzz/adjustment/add/index.dart';
import 'package:buzz/adjustment/adjustment_controller.dart';
import 'package:buzz/components/input_search.dart';
import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/select_periode.dart';
import 'package:buzz/components/shimmer_list.dart';
import 'package:buzz/components/shimmer_text.dart';
import 'package:buzz/components/spasi.dart';

import 'package:buzz/widgets/comuntitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Adjustment extends StatefulWidget {
  const Adjustment({super.key});

  @override
  State<Adjustment> createState() => _AdjustmentState();
}

class _AdjustmentState extends State<Adjustment> {
  final TextEditingController _search = TextEditingController();
  final AdjustmentController _controller = Get.put(AdjustmentController());

  @override
  void initState() {
    _controller.getCategoryData();
    _controller.getAdjustmentData("");
    super.initState();
  }

  Future<void> _pullRefresh() async {
    _controller.getAdjustmentData("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: [
            ComunTitle(title: 'Daftar Penyesuaian', path: "Penyesuaian"),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 150,
                child: Obx(() => SelectPeriode(
                      defValue: _controller.selectedMonth.value,
                      label: "",
                      menuItems: _controller.monthDropdown,
                      code: 'adjustment-month',
                      margin_left: 15,
                      margin_right: 5,
                    )),
              ),
              SizedBox(
                width: 150,
                child: Obx(() => SelectPeriode(
                      defValue: _controller.selectedYear.value,
                      label: "",
                      menuItems: _controller.yearDropdown,
                      code: 'adjustment-year',
                      margin_left: 0,
                      margin_right: 10,
                    )),
              ),
            ]),
            Jarak(tinggi: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Obx(() => _controller.categoryLoading.value
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: ShimmerText(
                        lebar: MediaQuery.of(context).size.width,
                        tinggi: 50,
                      ),
                    )
                  : SelectPeriode(
                      defValue: _controller.selectedCategory.value,
                      label: "",
                      menuItems: _controller.categoryDropdown,
                      code: 'adjustment-category',
                      margin_left: 15,
                      margin_right: 10,
                    )),
            ),
            Jarak(tinggi: 5),
            Jarak(tinggi: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Obx(
                () => _controller.loading.value
                    ? ShimmerList(tinggi: 110, jumlah: 10, pad: 0)
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _controller.adjustmentList.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Spasi(lebar: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Jarak(tinggi: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Transaction Date"),
                                          Text(
                                            _controller.adjustmentList[index]
                                                    ['date']
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.grey[400],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Category"),
                                          Text(
                                            _controller.adjustmentList[index]
                                                    ['category']
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.grey[400],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Total Product"),
                                          Text(_controller.adjustmentList[index]
                                                  ['totals']
                                              .toString()),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.grey[400],
                                      ),
                                      Container(
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
                                          title: Text("Adjustmented Product",
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
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      82,
                                                  child: ListView.builder(
                                                      physics:
                                                          const ScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: _controller
                                                          .adjustmentList[index]
                                                              ['detail']
                                                          .length,
                                                      itemBuilder:
                                                          (context, index2) {
                                                        return Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 5),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: Text(_controller
                                                                    .adjustmentList[
                                                                        index][
                                                                        'product_name']
                                                                        [index2]
                                                                    .toString()),
                                                              ),
                                                              Jarak(tinggi: 5),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Spasi(
                                                                      lebar: 8),
                                                                  SizedBox(
                                                                    width: MediaQuery.of(context).size.width *
                                                                            2 /
                                                                            8 -
                                                                        10,
                                                                    child: Text("@" +
                                                                        _controller
                                                                            .adjustmentList[index]['detail'][index2]['quantity']
                                                                            .toString()),
                                                                  ),
                                                                  SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        2 /
                                                                        8,
                                                                    child: Text(_controller
                                                                        .adjustmentList[
                                                                            index]
                                                                            [
                                                                            'detail']
                                                                            [
                                                                            index2]
                                                                            [
                                                                            'type']
                                                                        .toString()),
                                                                  ),
                                                                ],
                                                              ),
                                                              Divider(
                                                                color: Colors
                                                                    .grey[400],
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
                                    ],
                                  ),
                                  Jarak(tinggi: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      _controller.adjustmentList[index]
                                                  ['sync_status'] ==
                                              1
                                          ? Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Colors.grey.shade200),
                                              child: Icon(
                                                Icons.check,
                                                size: 15,
                                                color: Colors.black,
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                _showSynctDialog(
                                                    context,
                                                    _controller
                                                        .adjustmentList[index]
                                                            ['id']
                                                        .toString());
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.green),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color:
                                                        Colors.green.shade200),
                                                child: Icon(
                                                  Icons.sync,
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
                                              _controller.adjustmentList[index]
                                                      ['id']
                                                  .toString());
                                        },
                                        child: Container(
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
            )
          ],
        ),
      ),
    );
  }
}

void _showAlertDialog(BuildContext context, String id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Data'),
        content:
            Text("Are your sure, do your want to delete this transaction..?"),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Yes, Delete it'),
            onPressed: () {
              AdjustmentController _controller =
                  Get.put(AdjustmentController());
              _controller.adjustmentDelete(id);
              Get.back();
            },
          ),
        ],
      );
    },
  );
}

void _showSynctDialog(BuildContext context, String id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Are your sure?'),
        content:
            Text("You will syncronize this transaction into journal account ?"),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Yes, Syncronize it'),
            onPressed: () {
              AdjustmentController _controller =
                  Get.put(AdjustmentController());
              _controller.sync(id);
              Get.back();
            },
          ),
        ],
      );
    },
  );
}
