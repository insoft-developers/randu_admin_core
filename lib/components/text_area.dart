import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextArea extends StatelessWidget {
  String hint;
  int maxline;

  TextEditingController textEditingController;

  TextArea(
      {Key? key,
      required this.hint,
      required this.textEditingController,
      required this.maxline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 54),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        border: Border.all(color: Colors.grey.shade300, width: 2.0),
      ),
      child: TextField(
        controller: textEditingController,
        obscureText: false,
        keyboardType: TextInputType.multiline,
        maxLines: maxline,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
