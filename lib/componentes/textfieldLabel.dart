import 'package:flutter/material.dart';

class MyLabeledField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const MyLabeledField({
    Key? key,
    required this.labelText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
