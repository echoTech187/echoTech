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
      if (result['status'] == "success") {
        Auth.fromJson(
          {
            "userId": result['data']['id'],
            "username": result['data']['username'],
            "firstName": result['data']['firstName'],
            "lastName": result['data']['lastName'],
            "token": result['token']
          },
        );
      }
      return response.body;
    } else {
      return response.body;
    }
  }

  Future<Map<String, dynamic>> signOut(String userID, String token) async {
    var body = {"id": userID};
    http.Response response = await http.post(
        Uri.parse("http://192.168.61.199:3000/api/auth/logout"),
        body: json.encode(body),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });
    if (response.statusCode == 200) {
      dynamic result = json.decode(response.body);
      if (result['status'] == "success") {
        return result;
      }else{
        return result;
      }
    } else {
      return json.decode(response.body);
    }
  }
}
