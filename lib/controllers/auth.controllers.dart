import 'dart:convert';
import 'package:echo_tech/features/auth/signin.layout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:echo_tech/services/auth.services.dart';
import 'package:flutter/material.dart';

import '../components/loading.dart';
import '../features/home.dart';

class AuthController {
  AuthServices authServices = AuthServices();
  signUp(BuildContext context, {required Map<String, Object> data}) async {
    String authResult = await authServices.signUp(data:data);
    Map<String, dynamic> result = jsonDecode(authResult);
    if (result['status'] == "success") {
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        const Loading()
            .showAlertDialog(context, message: result['message']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            content: Text(result['message']),
          ),
        );
      }
      Future.delayed(
        const Duration(seconds: 3),
            () {
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>  const SigninLayout(),
              ),
            );
          }
        },
      );
    }else{
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        const Loading().showAlertDialog(context, message: result['message']);
        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text(result['message']),
          ),
        )
            .closed
            .then((SnackBarClosedReason reason) {
          if (context.mounted) {
            Navigator.of(context, rootNavigator: true).pop();
          }
        });
      }
    }
  }

  signIn(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      String authResult =
          (await AuthServices().signIn(email: email, password: password));
      Map<String, dynamic> result = jsonDecode(authResult);
      if (result['status'] == "success") {
        addSessionUserSharedPreferences("token", result['token']);
        addSessionUserSharedPreferences("userID", result['data']['id']);
        addSessionUserSharedPreferences("username", result['data']['username']);
        addSessionUserSharedPreferences("fullName",
            result['data']['firstName'] + " " + result['data']['lastName']);
        addSessionUserSharedPreferences("email", email);

        String? token = await getSessionUserSharedPreferences("token");
        if (token != null) {
          if (context.mounted) {
            Navigator.of(context, rootNavigator: true).pop();
            const Loading()
                .showAlertDialog(context, message: result['message']);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                content: Text(result['message']),
              ),
            );
          }
          Future.delayed(
            const Duration(seconds: 3),
            () {
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              }
            },
          );
        }
      } else {
        if (context.mounted) {
          Navigator.of(context, rootNavigator: true).pop();
          const Loading().showAlertDialog(context, message: result['message']);
          ScaffoldMessenger.of(context)
              .showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  content: Text(result['message']),
                ),
              )
              .closed
              .then((SnackBarClosedReason reason) {
            if (context.mounted) {
              Navigator.of(context, rootNavigator: true).pop();
            }
          });
        }
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      const Loading().showAlertDialog(context,
          message: "Username and password is required");
      ScaffoldMessenger.of(context)
          .showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              content: Text('Username and password is required'),
            ),
          )
          .closed
          .then((SnackBarClosedReason reason) {
        if (context.mounted) Navigator.of(context, rootNavigator: true).pop();
      });
    }
  }

  signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userID = await getSessionUserSharedPreferences("userID");
    String token = await getSessionUserSharedPreferences("token");
    dynamic result = await authServices.signOut(userID, token);
    if (result['status'] == "success") {
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        const Loading().showAlertDialog(context, message: result['message']);
        ScaffoldMessenger.of(context)
            .showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                content: Text(result['message']),
              ),
            )
            .closed
            .then(
          (SnackBarClosedReason reason) {
            prefs.clear();
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const SigninLayout(),
                ),
              );
            }
          },
        );
      }
    } else {
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        const Loading().showAlertDialog(context, message: result['message']);
        ScaffoldMessenger.of(context)
            .showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                content: Text(result['message']),
              ),
            )
            .closed
            .then(
          (SnackBarClosedReason reason) {
            if (context.mounted) {
              Navigator.of(context, rootNavigator: true).pop();
            }
          },
        );
      }
    }
  }

  addSessionUserSharedPreferences(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  getSessionUserSharedPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }
}
