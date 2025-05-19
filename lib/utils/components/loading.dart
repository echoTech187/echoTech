import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.blue[800],
        ),
      ),
    );
  }

  void overlay(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              Text("Loading"),
            ],
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        Navigator.pop(context);
      } //pop dialog
    });
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      clipBehavior: Clip.hardEdge,
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.ideographic,
        children: [
          const CircularProgressIndicator(),
          Container(
            width: 200,
            margin: const EdgeInsets.only(left: 15),
            child: const Text(
              "Mohon tunggu sebentar. \nPermintaan sedang diproses...",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
