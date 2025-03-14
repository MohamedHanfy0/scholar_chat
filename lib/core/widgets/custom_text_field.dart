import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final bool obscureText;
  final bool visibility;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.text,
    required this.onChanged,
    this.obscureText = false,
    this.visibility = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool visibility = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText ? visibility : false,
      validator: (value) {
        if (value!.isEmpty) {
          return 'field is requreid ?';
        }
        return null;
      },
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.text,
        border: OutlineInputBorder(),
        suffixIcon:
            widget.obscureText
                ? InkWell(
                  onTap: () {
                    setState(() {
                      visibility = !visibility;
                    });
                  },
                  child: Icon(
                    visibility ? Icons.visibility_off : Icons.visibility,
                  ),
                )
                : null,
      ),
    );
  }
}
