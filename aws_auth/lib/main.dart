import 'package:aws_auth/auth/auth_service.dart';
import 'package:aws_auth/signin/signin_page.dart';
import 'package:aws_auth/signup/signup_page.dart';
import 'package:aws_auth/verification/verification_page.dart';
import 'package:aws_auth/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64, ascii, utf8;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/auth.dart';
import 'feed/feed_page.dart';

const SERVER_IP = 'http://192.168.42.75:8000';
final storage = FlutterSecureStorage();
void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Auth(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences sharedPreferences;

  /*
  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if (jwt == null) return "";
    return jwt;
  }
  */

/*
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => SignInPage()),
          (Route<dynamic> route) => false);
    }
  }
*/
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _authService.showLogIn();
  }

/*
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => SignInPage()),
          (Route<dynamic> route) => false);
    }
  }
*/
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        /*
      routes: {
        '/': (context) => const SignInPage(),
        '/feed-page': (context) => const FeedPage(),
        '/sign-up': (context) => const SignUpPage(),
      },
      */

        home: SignInPage());
  }
}
