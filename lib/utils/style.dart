import 'package:flutter/material.dart';

const TextStyle labelStyle = TextStyle(color: Colors.black38, fontSize: 14);
ButtonStyle loginButtonStyle(BuildContext context) {
  return ButtonStyle(
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 60.0,
      ),
    ),
    shape: const WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    ),
    fixedSize: WidgetStatePropertyAll(
      Size.fromWidth(MediaQuery.sizeOf(context).width),
    ),
    backgroundColor: const WidgetStatePropertyAll(
      Color.fromRGBO(30, 49, 157, 1),
    ),
    textStyle: const WidgetStatePropertyAll(
      TextStyle(
        fontSize: 16,
      ),
    ),
  );
}

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
