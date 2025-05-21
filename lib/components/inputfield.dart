import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../utils/style.dart';

enum ValidateType {
  text,
  email,
  password,
  confirmPassword,
  defaultPassword,
  defaultConfirmPassword
}

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final ValidateType validateType;
  final String label;

  const InputField(
      {super.key,
      required this.controller,
      required this.inputType,
      required this.validateType,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: PhysicalModel(
        color: Colors.white,
        elevation: 6,
        shadowColor: Colors.transparent,
        child: TextFormField(
          controller: controller,
          keyboardType: inputType,
          decoration: inputDecoration(title: label, type: inputType),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          validator: (String? value) {
            switch (validateType) {
              case ValidateType.email:
                return _validateEmail(value);
              default:
                return _validateTextField(value, label);
            }
          },
        ),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final ValidateType validateType;
  final String label;
  final String? password;
  final Widget? showHidePassword;
  final bool visiblePassword;
  const PasswordField({
    super.key,
    required this.controller,
    required this.inputType,
    required this.validateType,
    required this.label,
    this.password,
    this.showHidePassword,
    this.visiblePassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: PhysicalModel(
        color: Colors.white,
        elevation: 6,
        shadowColor: Colors.transparent,
        child: TextFormField(
          controller: controller,
          keyboardType:
              visiblePassword ? TextInputType.visiblePassword : inputType,
          decoration: inputDecoration(
            title: label,
            type: inputType,
            eyeIcons: (inputType == TextInputType.visiblePassword)
                ? showHidePassword
                : const Text(""),
          ),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          validator: (String? value) {
            switch (validateType) {
              case ValidateType.email:
                return _validateEmail(value);
              case ValidateType.defaultPassword:
                return _validateDefaultPassword(value);
              case ValidateType.password:
                return _validatePassword(value);
              case ValidateType.confirmPassword:
                return _validateConfirmPassword(password!, value);
              default:
                return _validateTextField(value, label);
            }
          },
          obscuringCharacter: '*',
          obscureText: visiblePassword ? true : false,
        ),
      ),
    );
  }
}

String? _validateTextField(String? value, String title) {
  if (value!.isEmpty) {
    return 'Silahkan masukan $title anda.';
  } else {
    return null;
  }
}

String? _validateConfirmPassword(String? password, String? value) {
  if (password!.isEmpty) {
    return 'Silahkan masukan kata sandi anda.';
  } else {
    if (value!.isEmpty) {
      return 'Silahkan masukan konfirmasi kata sandi anda.';
    } else if (value.length < 8) {
      return "Kata sandi harus minimal 8 karakter";
    } else {
      if (password != value) {
        return 'Kata sandi harus sama seperti di atas.';
      } else {
        return null;
      }
    }
  }
}

String? _validatePassword(String? value) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  if (value!.isEmpty) {
    return 'Silahkan masukan kata sandi anda.';
  } else if (value.length < 8) {
    return "Kata sandi harus minimal 8 karakter";
  } else {
    if (!regex.hasMatch(value)) {
      return 'Masukan kata sandi yang benar.';
    } else {
      return null;
    }
  }
}

String? _validateDefaultPassword(String? value) {
  if (value!.isEmpty) {
    return 'Silahkan masukan password anda.';
  } else {
    return null;
  }
}

String? _validateEmail(String? value) {
  if (value!.isEmpty) {
    return 'Silahkan masukan email anda.';
  } else {
    final bool isValid = EmailValidator.validate(value);
    if (!isValid) {
      return 'Enter a valid email address';
    } else {
      const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
      final regex = RegExp(pattern);

      return value.isNotEmpty && !regex.hasMatch(value)
          ? 'Enter a valid email address'
          : null;
    }
  }
}
