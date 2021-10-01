import 'package:aws_auth/auth/auth_service.dart';
import 'package:aws_auth/signin/signin_page.dart';
import 'package:aws_auth/signup/signup_page.dart';
import 'package:aws_auth/verification/verification_page.dart';
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
  void initState() {
    super.initState();
    _authService.showLogIn();
  }

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

      home: StreamBuilder<AuthState>(
          stream: _authService.authStateController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Navigator(
                pages: [
                  // show Login page
                  if (snapshot.data?.authFlowStatus == AuthFlowStatus.login)
                    MaterialPage(
                        child: SignInPage(
                      didProvideCredentials: _authService.loginWithCredentials,
                      shouldShowSignUp: _authService.showSignUp,
                    )),
                  // show SignUp page
                  if (snapshot.data?.authFlowStatus == AuthFlowStatus.signup)
                    MaterialPage(
                        child: SignUpPage(
                      didProvideCredentials: _authService.signUpWithCredentials,
                      shouldShowLogin: _authService.showLogIn,
                    )),
                  // show Verification Code page
                  if (snapshot.data?.authFlowStatus ==
                      AuthFlowStatus.verification)
                    MaterialPage(
                        child: VerificationPage(
                            didProvideVerificationCode:
                                _authService.verifyingCode)),
                  if (snapshot.data?.authFlowStatus == AuthFlowStatus.session)
                    MaterialPage(
                        child: FeedPage(shouldLogOut: _authService.logOut))
                ],
                onPopPage: (route, result) => route.didPop(result),
              );
            } else {
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
