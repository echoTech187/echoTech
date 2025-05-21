import 'package:flutter/material.dart';

TextStyle labelStyle = TextStyle(fontSize: 14, color: Colors.grey[400]);


InputDecoration inputDecoration({
  required String title,
  TextInputType? type,
  Widget? eyeIcons,
  void Function(bool passwordVisible)? onClickEye,
}) {
  return InputDecoration(
    labelText: title,
    labelStyle: labelStyle,
    border: const OutlineInputBorder(),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    filled: true,
    fillColor: const Color.fromRGBO(0, 0, 0, 0.05),
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    suffixIcon: type == TextInputType.visiblePassword ? eyeIcons : null,
  );
}
