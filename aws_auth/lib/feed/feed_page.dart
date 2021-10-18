import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert' show ascii, base64, json, utf8;

const SERVER_IP = 'http://192.168.42.75:8000';

class FeedPage extends StatelessWidget {
  final String jwt;
  final Map<String, dynamic> payload;
  FeedPage(this.jwt, this.payload);

  factory FeedPage.fromBase64(String jwt) => FeedPage(
      jwt,
      json.decode(
          utf8.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: http.read(
              Uri.parse('http://192.168.42.75:8000/api/auth/user-profile'),
              headers: {"Authorization": jwt}),
          builder: (context, snapshot) => snapshot.hasData
              ? Column(
                  children: <Widget>[
                    Text("${payload['email']}, here's the data:"),
                    //Text(snapshot.data)
                  ],
                )
              : snapshot.hasError
                  ? Text("An Error occured")
                  : CircularProgressIndicator(),
        ),
      ),
    );
  }
}


/*
import 'package:aws_auth/auth/auth_service.dart';
import 'package:aws_auth/signin/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert' show ascii, base64, json, utf8;

import 'package:shared_preferences/shared_preferences.dart';

const SERVER_IP = 'http://192.168.42.75:8000';
final storage = FlutterSecureStorage();

class FeedPage extends StatefulWidget {
  //final VoidCallback shouldLogOut;
  final String jwt;
  final Map<String, dynamic> payload;
  const FeedPage({
    Key? key,
    required this.jwt,
    required this.payload,
  }) : super(key: key);

  factory FeedPage.fromBase64(String jwt) => FeedPage(
        jwt: jwt,
        payload: json.decode(
          utf8.decode(base64.decode(base64.normalize(jwt.split(".")[1]))),
        ),
      );

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late SharedPreferences sharedPreferences;

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => SignInPage()),
          (Route<dynamic> route) => false);
    }
  }

  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _authService.showLogIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: FutureBuilder(future: http.read(Uri.parse("http://192.168.42.75:8000/api"), headers: {"Authorization": jwt}), builder: builder),),
    )
    /*
    StreamBuilder<AuthState>(
      stream: _authService.authStateController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Navigator(
            pages: [
              if (snapshot.data?.authFlowStatus == AuthFlowStatus.session)
                MaterialPage(
                    child: FeedPage(
                  shouldLogOut: _authService.logOut,
                  jwt: '',
                  payload: {},
                ))
            ],
            onPopPage: (route, result) => route.didPop(result),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        }
      },
    );
    */
    /*
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          sharedPreferences.clear();
          sharedPreferences.commit();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => SignInPage()),
              (Route<dynamic> route) => false);
        },
        child: Text("Log Out"),
      ),
    );
    */
  }
}
*/