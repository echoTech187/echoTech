import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../views/auth/signin.dart';
import '../../views/auth/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: true,
      body: Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            controller:
            ScrollController(keepScrollOffset: false),
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              color: Colors.white,
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  const SizedBox(),
                  const SigninPage(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 12),
                    child: SizedBox(
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                color: Colors.black54),
                            children: [
                              const TextSpan(
                                  text:
                                  "Don't have a account? "),
                              TextSpan(
                                text: "Create account",
                                recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                        const SignUpPage(),
                                      ),
                                    );
                                  },
                                style: const TextStyle(
                                  color:
                                  Colors.blueAccent,
                                  fontWeight:
                                  FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
