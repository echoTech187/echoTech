import 'package:echo_tech/components/header.dart';
import 'package:echo_tech/components/inputfield.dart';
import 'package:echo_tech/components/logo.dart';
import 'package:flutter/material.dart';
import '../../components/button.dart';
import '../../components/loading.dart';
import '../../controllers/auth.controllers.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool aggrementController = false;
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    confirmPasswordVisible = true;
  }

  void signUpHandle(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.focusedChild?.unfocus();
      }
      const Loading().showAlertDialog(context);
      AuthController().signUp(
        context,
        data: {
          "firstName": firstNameController.text,
          "lastName": lastNameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "confirm_password": confirmPasswordController.text,
          "aggrement": aggrementController
        },
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
            const PrimaryHeader(label: "Buat akun baru"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputField(
                      controller: firstNameController,
                      inputType: TextInputType.text,
                      validateType: ValidateType.text,
                      label: "Nama Depan",
                    ),
                    InputField(
                      controller: lastNameController,
                      inputType: TextInputType.text,
                      validateType: ValidateType.text,
                      label: "Nama Belakang",
                    ),
                    InputField(
                      controller: emailController,
                      inputType: TextInputType.emailAddress,
                      validateType: ValidateType.email,
                      label: "Email",
                    ),
                    PasswordField(
                      controller: passwordController,
                      inputType: TextInputType.visiblePassword,
                      validateType: ValidateType.password,
                      label: "Password",
                      showHidePassword: IconButton(
                        icon: Icon(
                          confirmPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () => {
                          setState(() {
                            confirmPasswordVisible = !confirmPasswordVisible;
                          })
                        },
                      ),
                    ),
                    PasswordField(
                      controller: confirmPasswordController,
                      inputType: TextInputType.visiblePassword,
                      validateType: ValidateType.confirmPassword,
                      label: "Konfirmasi Password",
                      password: passwordController.text,
                      showHidePassword: IconButton(
                        icon: Icon(
                          confirmPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () => {
                          setState(() {
                            confirmPasswordVisible = !confirmPasswordVisible;
                          })
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      width: MediaQuery.sizeOf(context).width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (value) {
                              setState(() {
                                aggrementController = !value! ;
                              });
                            },
                            activeColor: Colors.green[100],
                            checkColor: Colors.green[800],
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width - 150,
                            child: const Text(
                              "Dengan menekan tombol daftar maka anda telah menyetujui dengan syarat dan ketentauan yang berlaku.",
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 10,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PrimaryButton(
                      context: context,
                      label: "Daftar",
                      onPress: () =>signUpHandle(context)
                    ),
                  ],
                ),
              ),
            ),
            const Center(
              child: SizedBox(
                child: Text(
                  "- atau daftar dengan - ",
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
                    platformType: PlatformType.register,
                    platform: "Google",
                    onTap: () {},
                  ),
                  SocialMediaButton(
                    platformType: PlatformType.register,
                    platform: "Facebook",
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
