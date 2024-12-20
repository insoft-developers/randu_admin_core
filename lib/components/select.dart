import 'package:buzz/adjustment/add/adjustment_add_controller.dart';
import 'package:buzz/adjustment/add_inter/adjustment_add_inter_controller.dart';
import 'package:buzz/adjustment/add_material/adjustment_add_material_controller.dart';
import 'package:buzz/expenses/expense/add/expense_add_controller.dart';
import 'package:buzz/manajemen_produk/product_list/add/product_add_controller.dart';
import 'package:buzz/manajemen_produk/product_list/edit/product_edit_controller.dart';
import 'package:buzz/pembelian/beli_produk_jadi/add/beli_produk_add_controller.dart';
import 'package:buzz/pembelian/beli_produk_jadi/beli_produk_jadi_controller.dart';
import 'package:buzz/pembelian/inter_purchase/add/inter_purchase_add_controller.dart';
import 'package:buzz/pembelian/manufacture/add/product_manufacture_add_controller.dart';
import 'package:buzz/pembelian/material_purchase/add/material_purchase_add.dart';
import 'package:buzz/pembelian/material_purchase/add/material_purchase_add_controller.dart';
import 'package:buzz/pengaturan/company_setting/company_setting_controller.dart';
import 'package:buzz/pengaturan/kas_kecil/kas_kecil_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SelectData extends StatelessWidget {
  String defValue;
  String label;
  List<DropdownMenuItem<String>> menuItems;
  String code;
  SelectData(
      {Key? key,
      required this.defValue,
      required this.label,
      required this.menuItems,
      required this.code})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 2.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonFormField(
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          value: defValue,
          onChanged: label == "readonly"
              ? null
              : (String? newValue) {
                  if (code == 'tipe-produk') {
                    ProductAddController _controller =
                        Get.put(ProductAddController());
                    _controller.onChangeProductType(newValue.toString());
                  } else if (code == 'buffered-stock') {
                    ProductAddController _controller =
                        Get.put(ProductAddController());
                    _controller.selectedBufferedStock.value =
                        newValue.toString();
                  } else if (code == 'manufactured') {
                    ProductAddController _controller =
                        Get.put(ProductAddController());
                    _controller.selectedProductMadeOf.value =
                        newValue.toString();
                  } else if (code == 'tipe-produk-edit') {
                    ProductEditController _controller =
                        Get.put(ProductEditController());
                    _controller.onChangeProductType(newValue.toString());
                  } else if (code == 'buffered-stock-edit') {
                    ProductEditController _controller =
                        Get.put(ProductEditController());
                    _controller.selectedBufferedStock.value =
                        newValue.toString();
                  } else if (code == 'manufactured-edit') {
                    ProductEditController _controller =
                        Get.put(ProductEditController());
                    _controller.selectedProductMadeOf.value =
                        newValue.toString();
                  } else if (code == 'payment-type') {
                    BeliProdukAddController _controller =
                        Get.put(BeliProdukAddController());
                    _controller.onChangePaymentType(newValue.toString());
                  } else if (code == 'account-id') {
                    BeliProdukAddController _controller =
                        Get.put(BeliProdukAddController());
                    _controller.onChangeAccoundId(newValue.toString());
                  } else if (code == 'product-manufacture-account-id') {
                    ProductManufactureAddController _controller =
                        Get.put(ProductManufactureAddController());
                    _controller.onChangeAccoundId(newValue.toString());
                  } else if (code == 'inter-purchase-account-id') {
                    InterPurchaseAddController _controller =
                        Get.put(InterPurchaseAddController());
                    _controller.onChangeAccoundId(newValue.toString());
                    newValue.toString();
                  } else if (code == 'material-payment-type') {
                    MaterialPurchaseAddController _controller =
                        Get.put(MaterialPurchaseAddController());
                    _controller.onChangePaymentType(newValue.toString());
                  } else if (code == 'material-account-id') {
                    MaterialPurchaseAddController _controller =
                        Get.put(MaterialPurchaseAddController());
                    _controller.onChangeAccoundId(newValue.toString());
                  } else if (code == 'product-purchase-supplier') {
                    BeliProdukAddController _controller =
                        Get.put(BeliProdukAddController());
                    _controller.selectedSupplier.value = newValue.toString();
                  } else if (code == 'material-purchase-supplier') {
                    MaterialPurchaseAddController _controller =
                        Get.put(MaterialPurchaseAddController());
                    _controller.selectedSupplier.value = newValue.toString();
                  } else if (code == 'adjustment-add-category') {
                    AdjustmentAddController _controller =
                        Get.put(AdjustmentAddController());
                    _controller.selectedCategory.value = newValue.toString();
                  } else if (code == 'adjustment-add-account') {
                    AdjustmentAddController _controller =
                        Get.put(AdjustmentAddController());
                    _controller.selectedAccount.value = newValue.toString();
                  } else if (code == 'adjustment-add-inter-product-category') {
                    AdjustmentAddInterProductController _controller =
                        Get.put(AdjustmentAddInterProductController());
                    _controller.selectedCategory.value = newValue.toString();
                  } else if (code == 'adjustment-add-inter-product-account') {
                    AdjustmentAddInterProductController _controller =
                        Get.put(AdjustmentAddInterProductController());
                    _controller.selectedAccount.value = newValue.toString();
                  } else if (code == 'adjustment-add-material-category') {
                    AdjustmentAddMaterialController _controller =
                        Get.put(AdjustmentAddMaterialController());
                    _controller.selectedCategory.value = newValue.toString();
                  } else if (code == 'adjustment-add-material-account') {
                    AdjustmentAddMaterialController _controller =
                        Get.put(AdjustmentAddMaterialController());
                    _controller.selectedAccount.value = newValue.toString();
                  } else if (code == 'expense-add-category') {
                    ExpenseAddController _controller =
                        Get.put(ExpenseAddController());
                    _controller.selectedCategory.value = newValue.toString();
                    print(_controller.selectedCategory);
                  } else if (code == 'expense-account-from') {
                    ExpenseAddController _controller =
                        Get.put(ExpenseAddController());
                    _controller.selectedAccount.value = newValue.toString();
                  } else if (code == 'expense-account-to') {
                    ExpenseAddController _controller =
                        Get.put(ExpenseAddController());
                    _controller.selectedAccountTo.value = newValue.toString();
                  } else if (code == 'company-bank') {
                    CompanySettingController _controller =
                        Get.put(CompanySettingController());
                    _controller.selectedBank.value = newValue.toString();
                  } else if (code == 'company-category') {
                    CompanySettingController _controller =
                        Get.put(CompanySettingController());
                    _controller.selectedCategory.value = newValue.toString();
                  } else if (code == 'petty-cash-setting') {
                    KasKecilController _controller =
                        Get.put(KasKecilController());
                    _controller.selected.value = newValue.toString();
                  }
                },
          items: menuItems),
    );
  }
}
