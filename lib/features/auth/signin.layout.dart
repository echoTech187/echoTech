import 'package:echo_tech/features/auth/signup.layout.dart';
import 'package:flutter/material.dart';
import '../../components/footer.dart';
import '../../ui/auth/signin.dart';

class SigninLayout extends StatefulWidget {
  const SigninLayout({super.key});

  @override
  State<SigninLayout> createState() => _SigninLayoutState();
}

class _SigninLayoutState extends State<SigninLayout> {
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
                  const SigninPage(),
                  PrimaryFooter(
                      question: "Belum punya akun?",
                      answer: "Daftar",
                      onTap: () {
                        print("masuk");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupLayout(),
                          ),
                        );
                      }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
