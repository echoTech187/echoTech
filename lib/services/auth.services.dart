import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/auth.model.dart';

class AuthServices {
  Future<String> signUp({required Map<String, dynamic> data}) async {
    try {
      http.Response response = await http.post(
          Uri.parse("http://192.168.61.199:3000/api/auth/register"),
          body: json.encode(data),
          headers: {
            "Content-Type": "application/json",
          }).timeout(const Duration(seconds: 3));

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['status'] == "success") {
          return response.body;
        }
        return response.body;
      } else {
        return response.body;
      }
    }catch(error){
      return '{"responseCode":500,"status":"error", "message":"Terjadi kesalahan. Silahkan coba beberapa saat lagi!"}';
    }
  }
  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      var body = {"email": email, "password": password};
      http.Response response = await http.post(
          Uri.parse("http://192.168.61.199:3000/api/auth/login"),
          body: json.encode(body),
          headers: {
            "Content-Type": "application/json",
          }).timeout(const Duration(seconds: 3));

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
    }catch(error){
      return '{"responseCode":500,"status":"error", "message":"Terjadi kesalahan. Silahkan coba beberapa saat lagi!"}';
    }
  }

  Future<Map<String, dynamic>> signOut(String userID, String token) async {
    try {
      var body = {"id": userID};
      http.Response response = await http
          .post(Uri.parse("http://192.168.61.199:3000/api/auth/logout"),
          body: json.encode(body),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          })
          .timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        dynamic result = json.decode(response.body);
        if (result['status'] == "success") {
          return result;
        } else {
          return result;
        }
      } else {
        return json.decode(response.body);
      }
    }catch(error){
      return json.decode(
          '{"responseCode":500,"status":"error", "message":"Terjadi kesalahan. Silahkan coba beberapa saat lagi!"}');
    }
  }
}
