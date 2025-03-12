import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String text;
  void Function(String)? onChanged;
  CustomTextField({Key? key, required this.text,required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(hintText: text, border: OutlineInputBorder()),
    );
  }
}
