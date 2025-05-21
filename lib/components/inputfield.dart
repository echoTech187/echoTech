import 'package:flutter/material.dart';

enum ValidateType {"text","email"}
class InputField extends StatelessWidget {
  const InputField({super.key, required this.controller, required this.inputType, required this.validateType});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
