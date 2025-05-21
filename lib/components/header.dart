import 'package:flutter/material.dart';

import '../utils/style/header.dart';

class PrimaryHeader extends StatelessWidget {
  final String label;

  const PrimaryHeader({super.key,required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        label,
        style: primaryHeader,
      ),
    );
  }
}
