import 'package:aws_auth/auth/auth_service.dart';
import 'package:aws_auth/signin/signin_page.dart';
import 'package:aws_auth/signup/signup_page.dart';
import 'package:flutter/material.dart';

import 'feed/feed_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      /*
      routes: {
        '/': (context) => const SignInPage(),
        '/feed-page': (context) => const FeedPage(),
        '/sign-up': (context) => const SignUpPage(),
      },
      */

      home: Navigator(
        pages: [
          MaterialPage(child: SignInPage()),
          MaterialPage(child: SignUpPage()),
          MaterialPage(child: FeedPage()),
        ],
      ),
    );
  }
}
