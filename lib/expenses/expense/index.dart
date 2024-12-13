import 'package:buzz/components/input_search.dart';
import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/select_periode.dart';
import 'package:buzz/components/shimmer_list.dart';
import 'package:buzz/components/shimmer_text.dart';
import 'package:buzz/components/spasi.dart';
import 'package:buzz/expenses/expense/add/index.dart';
import 'package:buzz/expenses/expense/expense_controller.dart';
import 'package:buzz/utils/helper.dart';

import 'package:buzz/widgets/comuntitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final TextEditingController _search = TextEditingController();
  final ExpenseController _controller = Get.put(ExpenseController());

  @override
  void initState() {
    _controller.getCategoryData();
    _controller.getExpenseData("");
    super.initState();
  }

  Future<void> _pullRefresh() async {
    _controller.getExpenseData("");
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
            ComunTitle(title: 'Daftar Pengeluaran', path: "Biaya (Expense)"),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 150,
                child: Obx(() => SelectPeriode(
                      defValue: _controller.selectedMonth.value,
                      label: "",
                      menuItems: _controller.monthDropdown,
                      code: 'expense-month',
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
                      code: 'expense-year',
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
                      code: 'expense-category',
                      margin_left: 15,
                      margin_right: 10,
                    )),
            ),
            Jarak(tinggi: 5),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: InputSearch(
                      hint: "Cari Keterangan Biaya",
                      textInputType: TextInputType.text,
                      iconData: Icons.search,
                      textEditingController: _search,
                      code: "cari-input-expense"),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ExpenseAdd())
                        ?.then((value) => _controller.getExpenseData(""));
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Obx(
                () => _controller.loading.value
                    ? ShimmerList(tinggi: 110, jumlah: 10, pad: 0)
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _controller.expenseList.length,
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
                                            _controller.expenseList[index]
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
                                            _controller.expenseList[index]
                                                    ['category_name']
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
                                          Text("Diambil dari"),
                                          Text(_controller.expenseList[index]
                                                  ['from_name']
                                              .toString()),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.grey[400],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Pengeluaran untuk"),
                                          Text(_controller.expenseList[index]
                                                  ['to_name']
                                              .toString()),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.grey[400],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Jumlah"),
                                          Text(Helper.formatAngka(_controller
                                              .expenseList[index]['amount']
                                              .toString())),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.grey[400],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Keterangan"),
                                          Text(_controller.expenseList[index]
                                                  ['keterangan']
                                              .toString()),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.grey[400],
                                      ),
                                    ],
                                  ),
                                  Jarak(tinggi: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      _controller.expenseList[index]
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
                                                        .expenseList[index]
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
                                              _controller.expenseList[index]
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
              ExpenseController _controller = Get.put(ExpenseController());
              _controller.expenseDelete(id);
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
              ExpenseController _controller = Get.put(ExpenseController());
              _controller.sync(id);
              Get.back();
            },
          ),
        ],
      );
    },
  );
}
