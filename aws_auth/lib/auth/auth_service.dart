import 'dart:async';

import 'package:flutter/cupertino.dart';

enum AuthFlowStatus { login, signup, verification, session }

class AuthState {
  final AuthFlowStatus authFlowStatus;

  AuthState({required this.authFlowStatus});
}

class AuthService {
  final authStateController = StreamController<AuthState>();

  void showSignUp() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.signup);
    authStateController.add(state);
  }

  void showLogIn() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.login);
    authStateController.add(state);
  }
}
