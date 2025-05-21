import 'package:echo_tech/components/footer.dart';
import 'package:echo_tech/features/auth/signin.layout.dart';
import 'package:echo_tech/ui/auth/signup.dart';
import 'package:flutter/material.dart';

class SignupLayout extends StatefulWidget {
  const SignupLayout({super.key});

  @override
  State<SignupLayout> createState() => _SignupLayoutState();
}

class _SignupLayoutState extends State<SignupLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.sizeOf(context).height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(),
                  const SignUpPage(),
                  PrimaryFooter(question: "Sudah punya akun?", answer: "Masuk", onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const SigninLayout(),
                      ),
                    );
                  })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
