import 'package:buzz/adjustment/adjustment_controller.dart';
import 'package:buzz/expenses/expense/expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SelectPeriode extends StatelessWidget {
  String defValue;
  String label;
  List<DropdownMenuItem<String>> menuItems;
  double margin_left;
  double margin_right;
  String code;
  SelectPeriode(
      {Key? key,
      required this.defValue,
      required this.label,
      required this.menuItems,
      required this.margin_left,
      required this.margin_right,
      required this.code})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: margin_right, left: margin_left),
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
                  if (code == 'adjustment-month') {
                    AdjustmentController _controller =
                        Get.put(AdjustmentController());
                    _controller.onchangeMonth(newValue.toString());
                  }

                  if (code == 'adjustment-year') {
                    AdjustmentController _controller =
                        Get.put(AdjustmentController());
                    _controller.onchangeYear(newValue.toString());
                  }

                  if (code == 'adjustment-category') {
                    AdjustmentController _controller =
                        Get.put(AdjustmentController());
                    _controller.onchangeCategory(newValue.toString());
                  }
                  if (code == 'expense-month') {
                    ExpenseController _controller =
                        Get.put(ExpenseController());
                    _controller.onchangeMonth(newValue.toString());
                  }

                  if (code == 'expense-year') {
                    ExpenseController _controller =
                        Get.put(ExpenseController());
                    _controller.onchangeYear(newValue.toString());
                  }

                  if (code == 'expense-category') {
                    ExpenseController _controller =
                        Get.put(ExpenseController());
                    _controller.onchangeCategory(newValue.toString());
                  }
                },
          items: menuItems),
    );
  }
}
