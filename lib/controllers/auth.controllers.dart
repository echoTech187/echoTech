import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:echo_tech/services/auth.services.dart';
import 'package:flutter/material.dart';

import '../features/home.dart';


class AuthController {
  signIn(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      String authResult =
          (await AuthServices().signIn(email: email, password: password));
      var result = jsonDecode(authResult);
      if (result['responseCode'] == 200 &&
          result['token'].toString().isNotEmpty) {
        try {
          final Future<SharedPreferencesWithCache> _prefs =
          SharedPreferencesWithCache.create(
              cacheOptions: const SharedPreferencesWithCacheOptions(
                  allowList: <String>{'token'}));
          final SharedPreferencesWithCache prefs = await _prefs;
          prefs.setString("token", result["token"]);
          String token = prefs.getString('token') ?? "";
          print(token);
          if(token.isNotEmpty){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(result['message']),

              ),
            );
            Future.delayed(const Duration(seconds: 3),(){
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) =>
                const HomePage(),
              ),);
            });

          }
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(error.toString()),
            ),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Username and password is required'),
        ),
      );
    }
  }
}
