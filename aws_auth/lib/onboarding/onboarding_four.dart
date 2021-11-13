import 'package:aws_auth/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../theme.dart';
import 'input_date_screen.dart';

class OnboardingFourScreen extends StatefulWidget {
  const OnboardingFourScreen({Key? key}) : super(key: key);

  @override
  _OnboardingFourScreenState createState() => _OnboardingFourScreenState();
}

class _OnboardingFourScreenState extends State<OnboardingFourScreen> {
  bool _isLoading = false;
  Text value = Text('');
  late var email;

  final storage = FlutterSecureStorage();
  //String? myEmail = await storage.read(key: "email");
  void _updateSplashFive() async {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Auth>(context, listen: false).updateSplashFive(
        data: {'is_splash_five': 1, 'email': await storage.read(key: 'email')},
        success: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return InputDateScreen();
          }));
        },
        error: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return OnboardingFourScreen();
          }));
        });
  }

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
                      onPressed: _isLoading ? null : () => _updateSplashFive(),
                      child: Text('Onboarding Four'),
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
