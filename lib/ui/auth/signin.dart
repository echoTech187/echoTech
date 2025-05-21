import 'package:echo_tech/controllers/auth.controllers.dart';
import 'package:flutter/material.dart';
import '../../components/button.dart';
import '../../components/header.dart';
import '../../components/inputfield.dart';
import '../../components/loading.dart';
import '../../components/logo.dart';

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

  void signInHandle(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.focusedChild?.unfocus();
      }
      const Loading().showAlertDialog(context);
      AuthController().signIn(
        context,
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      constraints: const BoxConstraints(),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppLogo(),
            const PrimaryHeader(label: "Masuk dengan akun anda."),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputField(
                      controller: emailController,
                      inputType: TextInputType.emailAddress,
                      validateType: ValidateType.email,
                      label: 'Email',
                    ),
                    PasswordField(
                      controller: passwordController,
                      inputType: TextInputType.visiblePassword,
                      validateType: ValidateType.defaultPassword,
                      label: 'Password',
                      showHidePassword: IconButton(
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
                    PrimaryButton(
                      context: context,
                      label: "Masuk",
                      onPress: () => signInHandle(context),
                    ),
                  ],
                ),
              ),
            ),
            const Center(
              child: SizedBox(
                child: Text(
                  "- atau masuk dengan - ",
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
                  SocialMediaButton(
                    platformType: PlatformType.login,
                    platform: 'Google',
                    onTap: () {},
                  ),
                  SocialMediaButton(
                    platformType: PlatformType.login,
                    platform: 'Facebook',
                    onTap: () {},
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
