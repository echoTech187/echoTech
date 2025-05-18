import 'package:echo_tech/controllers/auth.controllers.dart';
import 'package:flutter/material.dart';

import '../../utils/components/button.dart';
import '../../utils/style.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      constraints: const BoxConstraints(),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.5),
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Image(
                image: AssetImage("public/assets/logo.png"),
                height: 150,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              child: Text(
                "Login to your account",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    PhysicalModel(
                      color: Colors.white,
                      elevation: 6,
                      shadowColor: Colors.black45,
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: inputDecoration(
                          title: "Email",
                          type: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PhysicalModel(
                      color: Colors.white,
                      elevation: 6,
                      shadowColor: Colors.black45,
                      child: TextField(
                        decoration: inputDecoration(
                          title: "Password",
                          type: TextInputType.visiblePassword,
                          eyeIcons: IconButton(
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () => {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              })
                            },
                          ),
                        ),
                        keyboardType: passwordVisible
                            ? TextInputType.text
                            : TextInputType.visiblePassword,
                        controller: passwordController,
                        obscuringCharacter: '*',
                        obscureText: passwordVisible ? true : false,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    loginButton(
                      context,
                      text: const Text("Sign In"),
                      onPress: () {
                        AuthController().signIn(
                          context,
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Center(
              child: SizedBox(
                child: Text(
                  "- or login with - ",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: 24,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: Image(
                              image: AssetImage("public/assets/google.png"),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            "Login with Google",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: 24,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: Image(
                              image: AssetImage("public/assets/facebook.png"),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            "Login with Facebook",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
