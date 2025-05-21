import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: const Image(
          image: AssetImage("public/assets/icons/logo.png"),
          height: 150,
        ),
      ),
    );
  }
}
