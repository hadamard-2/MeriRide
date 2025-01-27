import 'package:flutter/material.dart';

class MyPasswordField extends StatefulWidget {
  final String label;
final TextEditingController? controller;

  const MyPasswordField({super.key, required this.label, this.controller});

  @override
  State<MyPasswordField> createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !passwordVisible,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_rounded),
        suffixIcon: InkWell(
          onTap: () => setState(() => passwordVisible = !passwordVisible),
          child: const Icon(Icons.visibility_rounded),
        ),
        labelText: widget.label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        } else if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }
}
