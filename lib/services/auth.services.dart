import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/auth.model.dart';

class AuthServices {
  Future<String> signIn(
      {required String email, required String password}) async {
    var body = {"email": email, "password": password};
    http.Response response = await http.post(
        Uri.parse("http://192.168.61.199:3000/api/auth/login"),
        body: json.encode(body),
        headers: {
          "Content-Type": "application/json",
        });
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      Auth.fromJson(
        {
          "userId": result['data']['id'],
          "username": result['data']['username'],
          "firstName": result['data']['firstName'],
          "lastName" : result['data']['lastName'],
          "token": result['token']
        },
      );
      return response.body;
    }else{
      return response.body;
    }

  }
}
