import 'package:aws_auth/auth/auth.dart';
import 'package:aws_auth/signin/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            const Text('This is Profile page. If you want to sign out, '),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInPage()));
                Provider.of<Auth>(context, listen: false).signOut(success: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("You have been signed out!")));
                });
              },
              child: Text(
                'Sign Out',
                style: darkPurpleTextStyle.copyWith(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
