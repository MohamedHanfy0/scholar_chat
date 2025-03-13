import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final void Function(String)? onChanged;
  const CustomTextField({
    super.key,
    required this.text,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'field is requreid ?';
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(hintText: text, border: OutlineInputBorder()),
    );
  }
}
