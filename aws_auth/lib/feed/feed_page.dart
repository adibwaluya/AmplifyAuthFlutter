import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  final VoidCallback shouldLogOut;
  const FeedPage({Key? key, required this.shouldLogOut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: Icon(Icons.logout),
          onTap: shouldLogOut,
        ),
      ),
    );
  }
}
