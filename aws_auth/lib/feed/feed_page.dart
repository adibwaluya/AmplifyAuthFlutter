import 'package:aws_auth/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FeedPage extends StatefulWidget {
  final VoidCallback shouldLogOut;
  const FeedPage({Key? key, required this.shouldLogOut}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    StreamBuilder<AuthState>(
      stream: _authService.authStateController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Navigator(
            pages: [
              if (snapshot.data?.authFlowStatus == AuthFlowStatus.session)
                MaterialPage(child: FeedPage(shouldLogOut: _authService.logOut))
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
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: Icon(Icons.logout),
          onTap: widget.shouldLogOut,
        ),
      ),
    );
  }
}
