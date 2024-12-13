import 'dart:io';

import 'package:buzz/adjustment/add/adjustment_add_controller.dart';
import 'package:buzz/components/input_display.dart';
import 'package:buzz/components/input_readonly.dart';
import 'package:buzz/components/input_text.dart';
import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/judul.dart';
import 'package:buzz/components/select.dart';
import 'package:buzz/components/shimmer_text.dart';
import 'package:buzz/components/spasi.dart';
import 'package:buzz/components/text_area.dart';
import 'package:buzz/expenses/expense/add/expense_add_controller.dart';

import 'package:buzz/new_appbar.dart';
import 'package:buzz/pembelian/beli_produk_jadi/add/beli_produk_add_controller.dart';
import 'package:buzz/utils/helper.dart';

import 'package:buzz/widgets/comuntitle.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExpenseAdd extends StatefulWidget {
  const ExpenseAdd({super.key});

  @override
  State<ExpenseAdd> createState() => _ExpenseAddState();
}

class _ExpenseAddState extends State<ExpenseAdd> {
  final ExpenseAddController _controller = Get.put(ExpenseAddController());
  final TextEditingController _tanggal = TextEditingController();
  final TextEditingController _keterangan = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  @override
  void initState() {
    var now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    _tanggal.text = formattedDate;
    _controller.selectedCategory.value = "";
    _controller.selectedAccount.value = "";

    _controller.getCategoryData();
    _controller.getAccountData();
    _controller.getAccountToData();
    super.initState();
  }

  _onDateChange() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2101));
    String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate!);
    setState(() {
      _tanggal.text = formattedDate;
    });
  }

  _expenseStore() {
    _controller.expenseStore(_tanggal.text, _amount.text, _keterangan.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewAppBar(),
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          ComunTitle(title: 'Tambah \nPengeluaran', path: "Biaya (Expense)"),
          Jarak(tinggi: 20),
          Judul(nama: "Tanggal Transaksi", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Container(
            width: MediaQuery.of(context).size.width * 1 / 3 - 10,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(10)),
            height: 50,
            child: TextField(
              controller: _tanggal,
              decoration: const InputDecoration(
                hintText: "Tanggal",
                border: InputBorder.none,
                filled: false,
              ),
              readOnly: true,
              onTap: () {
                _onDateChange();
              },
            ),
          ),
          Jarak(tinggi: 30),
          Judul(nama: "Kategori", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(() => _controller.categoryLoading.value
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ShimmerText(
                    lebar: MediaQuery.of(context).size.width,
                    tinggi: 50,
                  ),
                )
              : SelectData(
                  defValue: _controller.selectedCategory.value,
                  label: "",
                  menuItems: _controller.categoryDropdown,
                  code: 'expense-add-category',
                )),
          Jarak(tinggi: 30),
          Judul(nama: "Diambil dari", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(() => _controller.accountLoading.value
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ShimmerText(
                    lebar: MediaQuery.of(context).size.width,
                    tinggi: 50,
                  ),
                )
              : SelectData(
                  defValue: _controller.selectedAccount.value,
                  label: "",
                  menuItems: _controller.accountDropdown,
                  code: 'expense-account-from',
                )),
          Jarak(tinggi: 30),
          Judul(nama: "Pengeluaran untuk", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(() => _controller.accountToLoading.value
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ShimmerText(
                    lebar: MediaQuery.of(context).size.width,
                    tinggi: 50,
                  ),
                )
              : SelectData(
                  defValue: _controller.selectedAccountTo.value,
                  label: "",
                  menuItems: _controller.accounTotDropdown,
                  code: 'expense-account-to',
                )),
          Jarak(tinggi: 30),
          Judul(nama: "Jumlah", pad: 20, ukuran: 16, mandatory: 1),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300, width: 2.0),
            ),
            child: TextField(
              controller: _amount,
              obscureText: false,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: "Jumlah biaya yang dikeluarkan",
                hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Jarak(tinggi: 5),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(Helper.formatAngka(_amount.text),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red))),
          Jarak(tinggi: 30),
          Judul(nama: "Keterangan", pad: 20, ukuran: 16, mandatory: 0),
          Jarak(tinggi: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextArea(
                hint: "Tambahkan keterangan disini...",
                textEditingController: _keterangan,
                maxline: 5),
          ),
          Jarak(tinggi: 50),
          Obx(
            () => _controller.loading.value
                ? const SizedBox(
                    child: Center(child: CircularProgressIndicator()))
                : Center(
                    child: InkWell(
                    onTap: () {
                      _expenseStore();
                    },
                    splashColor: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.green.withOpacity(0.8)),
                        child: Text("Simpan",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16))),
                  )),
          ),
          Jarak(tinggi: 150),
        ],
      ),
    );
  }
}
