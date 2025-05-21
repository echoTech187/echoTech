import 'package:flutter/material.dart';
import '../../components/button.dart';
import '../../components/loading.dart';
import '../../controllers/auth.controllers.dart';
import '../../utils/style.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    confirmPasswordVisible=true;
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
                "Create new your account",
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
                        controller: firstNameController,
                        keyboardType: TextInputType.text,
                        decoration: inputDecoration(
                          title: "First Name",
                          type: TextInputType.text,
                        ),
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
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
                        controller: lastNameController,
                        keyboardType: TextInputType.text,
                        decoration: inputDecoration(
                          title: "Last Name",
                          type: TextInputType.text,
                        ),
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
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
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: inputDecoration(
                          title: "Email",
                          type: TextInputType.emailAddress,
                        ),
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
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
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
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
                          title: "Confirm Password",
                          type: TextInputType.visiblePassword,
                          eyeIcons: IconButton(
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
                        keyboardType: confirmPasswordVisible
                            ? TextInputType.text
                            : TextInputType.visiblePassword,
                        controller: confirmPasswordController,
                        obscuringCharacter: '*',
                        obscureText: confirmPasswordVisible ? true : false,
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PrimaryButton(
                      context:context,
                      label: "Sign Up",
                      onPress: () {
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
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Center(
              child: SizedBox(
                child: Text(
                  "- or login with - ",
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
