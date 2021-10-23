import 'dart:convert';

import 'package:aws_auth/auth/user.dart';
import 'package:aws_auth/dio.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth extends ChangeNotifier {
  final storage = new FlutterSecureStorage();

  late var token;
  bool authenticated = false;
  late User? authenticatedUser; // To be updated!

  get loggedIn {
    return authenticated;
  }

  get user {
    return authenticatedUser;
  }

  Future signin(
      {Map? data, required Function success, required Function error}) async {
    try {
      Dio.Response response =
          await dio().post('auth/login', data: json.encode(data));

      var token = json.decode(response.toString())['data']['token'];

      this._setStoredToken(token);
      this.attempt(token: token);
      notifyListeners();

      success();
    } catch (e) {
      error();
    }
  }

  // TODO!
  Future signUp(
      {Map? data, required Function success, required Function error}) async {
    try {
      Dio.Response response =
          await dio().post('auth/register', data: json.encode(data));
    } catch (e) {}
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
      Dio.Response response = await dio().get(
        'auth/user-profile',
      );
      this.authenticated = true;
      print(json.decode(response.toString())['data']);
      notifyListeners();
    } catch (e) {
      _setUnauthenticated();
    }
  }

  void signOut({required Function success}) async {
    try {
      await dio().post('auth/logout');
      this._setUnauthenticated();
      notifyListeners();
    } catch (e) {}
  }

  void _setUnauthenticated() async {
    authenticated = false;
    authenticatedUser = null;
    await storage.delete(key: 'token');
  }

  void _setStoredToken(String token) async {
    await storage.write(key: 'token', value: token);
  }
}
