import 'package:flutter/material.dart';

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