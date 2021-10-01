import 'package:aws_auth/auth/auth_credentials.dart';
import 'package:aws_auth/signin/signin_page.dart';
import 'package:aws_auth/signup/signup_background.dart';
import 'package:aws_auth/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback shouldShowLogin;
  final ValueChanged<SignUpCredentials> didProvideCredentials;
  const SignUpPage(
      {Key? key,
      required this.didProvideCredentials,
      required this.shouldShowLogin})
      : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget nameInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: greyColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Row(children: [
                  Image.asset(
                    "assets/icons/Avatar_icon.png",
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: TextFormField(
                    controller: _usernameController,
                    style: blackRegularTextStyle,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Nama Lengkap Kamu',
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

    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
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
                  SizedBox(
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
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
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
                  SizedBox(
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
        margin: EdgeInsets.only(top: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sudah memiliki Akun? ',
              style: greyTextStyle.copyWith(fontSize: 12),
            ),
            GestureDetector(
              onTap: widget.shouldShowLogin,
              child: Text(
                'Sign In',
                style: darkPurpleTextStyle.copyWith(fontSize: 12),
              ),
            ),
          ],
        ),
      );
    }

    void _signUp() {
      final username = _usernameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      print('$username');
      print('$email');
      print('$password');

      final credentials = SignUpCredentials(
        username: username,
        email: email,
        password: password,
      );
      widget.didProvideCredentials(credentials);
    }

    return SafeArea(
      child: Scaffold(
        body: SignUpBackground(
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
                  SizedBox(
                    height: 22,
                  ),
                  Text(
                    'Sign Up',
                    style: blackSemiBoldTextStyle.copyWith(fontSize: 30),
                  ),
                  nameInput(),
                  emailInput(),
                  passwordInput(),
                  /* TODO: TO BE MOVED ASAP! */
                  Container(
                    height: 50,
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: 25,
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          _signUp();
                        },
                        child: Text(
                          'Sign Up',
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
