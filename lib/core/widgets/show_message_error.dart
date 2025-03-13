import 'package:flutter/material.dart';

void showMessageError(BuildContext context, Object e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.red, content: Text(e.toString())),
    );
  }