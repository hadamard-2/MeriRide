import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String text;
  final Icon prefixIcon;

  const MyTextField({super.key, required this.text, required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: text,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
