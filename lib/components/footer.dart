import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../utils/style/footer.dart';

class PrimaryFooter extends StatelessWidget {
  final String question;
  final String answer;
  final void Function()? onTap;

  const PrimaryFooter(
      {super.key,
      required this.question,
      required this.answer,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.sizeOf(context).width,
      child: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: question,
                style: questionText,
              ),
              const TextSpan(text: " "),
              TextSpan(
                text: answer,
                recognizer: TapGestureRecognizer()..onTap = onTap,
                style: answerText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
