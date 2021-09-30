import 'package:aws_auth/signin/signin_background.dart';
import 'package:aws_auth/signup/signup_page.dart';
import 'package:aws_auth/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget emailInput() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: greyColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Row(children: [
                  Image.asset(
                    "assets/icons/Email_icon.png",
                    width: 25,
                    height: 25,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: TextFormField(
                    controller: _emailController,
                    style: blackRegularTextStyle,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Email Kamu',
                      hintStyle: hintTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                  )),
                ]),
              ),
            ),
          ],
        ),
      );
    }

    Widget passwordInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: greyColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Row(children: [
                  Image.asset(
                    "assets/icons/Lock_icon.png",
                    width: 25,
                    height: 25,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: TextFormField(
                    controller: _passwordController,
                    style: blackRegularTextStyle,
                    obscureText: true,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Password',
                      hintStyle: hintTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                  )),
                ]),
              ),
            ),
          ],
        ),
      );
    }

    Widget createAccount() {
      return Container(
        margin: const EdgeInsets.only(top: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Belum mempunyai Akun? ',
              style: greyTextStyle.copyWith(fontSize: 12),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpPage()));
              },
              child: Text(
                'Sign Up',
                style: darkPurpleTextStyle.copyWith(fontSize: 12),
              ),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: SignInBackground(
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 65, right: 65),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/Nusatutor_logo_transparant.png',
                    width: 140,
                    height: 122.28,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Text(
                    'Nusaplanner',
                    style: blackSemiBoldTextStyle.copyWith(fontSize: 30),
                  ),
                  emailInput(),
                  passwordInput(),
                  /* TODO: TO BE MOVED ASAP! */
                  Container(
                    height: 50,
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      top: 25,
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const BottomNavigation();
                            }),
                          );
                        },
                        child: Text(
                          'Sign In',
                          style: whiteTextStyle.copyWith(fontSize: 16),
                        ),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(whiteColor),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(darkPurpleColor),
                        )),
                  ),
                  createAccount(),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
