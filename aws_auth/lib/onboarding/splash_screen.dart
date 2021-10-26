import 'package:aws_auth/onboarding/input_date_screen.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0, left: 10, right: 10),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/Nusatutor_logo_transparant.png',
                      width: 70,
                      height: 61.14,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Plan your Study with Only One App',
                      style: blackSemiBoldTextStyle.copyWith(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Belajar saat ini tidak mesti ribet, apalagi mahal.\nPersingkat waktu kamu dengan menggunakan\naplikasi ini.',
                      style: greyTextStyle.copyWith(fontSize: 12),
                    ),
                    SizedBox(
                      height: 42,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return InputDateScreen();
                          }),
                        );
                      },
                      child: Text('Start Planning'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
