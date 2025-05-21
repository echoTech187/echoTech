import 'package:flutter/material.dart';

import '../style.dart';

Widget loginButton(
  BuildContext context, {
  required Widget text,
  required Function() onPress,
}) =>
    PhysicalModel(
      color: Colors.transparent,
      elevation: 6,
      shadowColor: Colors.black45,
      child: FilledButton(
        onPressed: onPress,
        style: loginButtonStyle(context),
        child: text,
      ),
    );
