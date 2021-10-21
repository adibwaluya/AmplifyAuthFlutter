import 'dart:convert';

import 'package:aws_auth/dio.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  late String token;
  bool authenticated = false;

  get loggedIn {
    return authenticated;
  }

  Future signin(
      {Map? data, required Function success, required Function error}) async {
    try {
      Dio.Response response =
          await dio().post('auth/login', data: json.encode(data));

      var token = json.decode(response.toString())['data']['token'];

      this.attempt(token: token);
      notifyListeners();

      success();
    } catch (e) {
      error();
    }
  }

  void attempt({token = ''}) async {
    if (token.toString().isNotEmpty) {
      this.token = token;
    }

    // No preexisting token, just return. No attempt on authentication
    if (this.token.toString().isEmpty) {
      return;
    }

    try {
      Dio.Response response = await dio().get('auth/user-profile',
          options: Dio.Options(
            headers: {
              'Authorization': 'Bearer $token', // set content-length
            },
          ));
      this.authenticated = true;
      print(json.decode(response.toString())['data']);
      notifyListeners();
    } catch (e) {
      this.authenticated = false;
    }
  }
}
