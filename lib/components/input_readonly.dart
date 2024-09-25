import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputReadonly extends StatelessWidget {
  String hint;
  TextInputType textInputType;
  TextEditingController textEditingController;
  bool obsecureText;
  String code;

  InputReadonly(
      {Key? key,
      required this.hint,
      required this.textInputType,
      required this.textEditingController,
      required this.obsecureText,
      required this.code})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Stack(
        children: [
          TextField(
            controller: textEditingController,
            obscureText: false,
            readOnly: true,
            keyboardType: textInputType,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            onChanged: (value) {},
          ),
          Positioned(
            right: 0,
            top: 10,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey),
                child: Icon(Icons.arrow_downward, color: Colors.white)),
          )
        ],
      ),
    );
  }
}
