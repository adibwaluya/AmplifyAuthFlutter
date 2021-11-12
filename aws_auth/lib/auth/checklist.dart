import 'dart:convert';

import 'package:aws_auth/auth/splash_screens.dart';
import 'package:aws_auth/auth/user.dart';
import 'package:aws_auth/dio.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Checklist extends ChangeNotifier {
  final storage = new FlutterSecureStorage();

  late var token;
  late var isSplashOne;
  late var isSplashTwo;
  late var email;
  //late IsSplashScreens splashScreens;

  bool authenticated = false;
  late User? authenticatedUser; // To be updated!

  get loggedIn {
    return authenticated;
  }

  get user {
    return authenticatedUser;
  }

  get registered {
    return authenticated;
  }

  Future signin(
      {Map? data, required Function success, required Function error}) async {
    try {
      Dio.Response response =
          await dio().post('auth/login', data: json.encode(data));

      var token = json.decode(response.toString())['access_token'];

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

      var token = json.decode(response.toString())['access_token'];
      var email = json.decode(response.toString())['user']['email'];
      print(token);
      this._setStoredToken(token);
      this._setStoredEmail(email);
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
      Dio.Response response = await dio().get(
        'auth/user-profile',
      );

      this.authenticated = true;

      this.authenticatedUser =
          User.fromJson(json.decode(response.toString())['data']);
      print(json.decode(response.toString())['data']);
      notifyListeners();
    } catch (e) {
      _setUnauthenticated();
    }
  }

  void updateSplashOne(
      {Map? data, required Function success, required Function error}) async {
    try {
      Dio.Response response =
          await dio().post('auth/update-splashOne', data: json.encode(data));

      notifyListeners();

      success();
      print(response);
    } catch (e) {
      error();
    }
  }

  void updateSplashTwo(
      {Map? data, required Function success, required Function error}) async {
    try {
      Dio.Response response =
          await dio().post('auth/update-splashTwo', data: json.encode(data));

      notifyListeners();
      success();
    } catch (e) {
      error();
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

  void _setStoredEmail(String email) async {
    await storage.write(key: 'email', value: email);
  }

  void _setStoredSplashOne(String confirmed) async {
    await storage.write(key: 'splashOne', value: confirmed);
  }

  void _setStoredSplashTwo(String confirmed) async {
    await storage.write(key: 'splashTwo', value: confirmed);
  }

  void _getStoredSplashOne(String token) async {
    await storage.read(key: token);
  }
}
