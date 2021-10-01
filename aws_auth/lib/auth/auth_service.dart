import 'dart:async';

import 'package:aws_auth/auth/auth_credentials.dart';
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

  void loginWithCredentials(AuthCredentials credentials) {
    final state = AuthState(authFlowStatus: AuthFlowStatus.session);
    authStateController.add(state);
  }

  void signUpWithCredentials(AuthCredentials credentials) {
    final state = AuthState(authFlowStatus: AuthFlowStatus.verification);
    authStateController.add(state);
  }
}
