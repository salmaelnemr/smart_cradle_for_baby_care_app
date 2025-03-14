import 'package:flutter/material.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const MyInputField({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,

            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: "Roboto"),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.only(left: 12),
            height: 52,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                      readOnly: widget==null?false:true,
                      autofocus: false,
                      cursorColor: Colors.grey,
                      controller: controller,
                      style: TextStyle(fontSize: 16, color: Colors.grey[850]),
                      decoration: InputDecoration(
                          hintText: hint,
                          hintStyle:
                          const TextStyle(fontSize: 16, color: Colors.grey),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white, width: 0)),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white, width: 0))),
                    )
                ),
                widget==null?Container():Container(child: widget)
              ],
            ),
          )
        ],
      ),
    );
  }
}