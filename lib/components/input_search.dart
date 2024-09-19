// ignore: must_be_immutable
import 'package:flutter/material.dart';

class InputSearch extends StatelessWidget {
  String hint;
  TextInputType textInputType;
  IconData iconData;
  TextEditingController textEditingController;
  String code;

  InputSearch(
      {Key? key,
      required this.hint,
      required this.textInputType,
      required this.iconData,
      required this.textEditingController,
      required this.code})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        border: Border.all(color: Colors.grey, width: 0.5),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 1), blurRadius: 50, color: Colors.white),
        ],
      ),
      child: TextField(
        controller: textEditingController,
        onChanged: (value) {},
        keyboardType: textInputType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          icon: SizedBox(
            height: 30,
            width: 30,
            child: Icon(iconData),
          ),
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
