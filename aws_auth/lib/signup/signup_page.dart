import 'package:aws_auth/auth/auth.dart';
import 'package:aws_auth/auth/auth_credentials.dart';
import 'package:aws_auth/feed/feed_page.dart';
import 'package:aws_auth/onboarding/splash_screen.dart';
import 'package:aws_auth/signin/signin_page.dart';
import 'package:aws_auth/signup/signup_background.dart';
import 'package:aws_auth/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:convert' show json, base64, ascii, utf8;

import '../theme.dart';

const SERVER_IP = 'http://192.168.42.75:8000';
final storage = FlutterSecureStorage();

class SignUpPage extends StatefulWidget {
  //final VoidCallback shouldShowLogin;
  //final ValueChanged<SignUpCredentials> didProvideCredentials;
  const SignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  int isSplashOne = 0;
  int isSplashTwo = 0;
  final dateStart = "dd/mm/YYYY";
  final dateEnd = "dd/mm/YYYY";

  bool _isLoading = false;

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(text),
        ),
      );

  Future<int> attemptSignUp(String name, String email, String password,
      String passwordConfirmation) async {
    var res = await http.post(Uri.parse('$SERVER_IP/api/auth/register'), body: {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "is_splash_one": false,
      "is_splash_two": false
    });
    var jsonResponse = null;
    if (res.statusCode == 201) {
      setState(() {
        _isLoading = true;
      });
      jsonResponse = json.decode(res.body);
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
    }
    return res.statusCode;
  }

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

    Widget passwordConfirmationInput() {
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
                    controller: _passwordConfirmationController,
                    style: blackRegularTextStyle,
                    obscureText: true,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Password Confirmation',
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
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInPage()));
              },
              child: Text(
                'Sign In',
                style: darkPurpleTextStyle.copyWith(fontSize: 12),
              ),
            ),
          ],
        ),
      );
    }

/*
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
*/

    void _submit() {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Auth>(context, listen: false).signUp(
          data: {
            'name': _usernameController.text,
            'email': _emailController.text,
            'password': _passwordController.text,
            'password_confirmation': _passwordConfirmationController.text,
            'is_splash_one': 0,
            'is_splash_two': 0,
            'is_splash_three': 0,
            'is_splash_four': 0,
            'is_splash_five': 0,
            'is_splash_six': 0,
            'date_start': dateStart,
            'date_end': dateEnd
          },
          success: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return SplashScreen();
            }));
          },
          error: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return SignUpPage();
            }));
            if (_usernameController.text.length < 4) {
              displayDialog(context, 'Invalid Username',
                  'The Username should be at least 4 characters');
            } else if (_emailController.text.isEmpty) {
              displayDialog(context, 'Invalid Email',
                  'Please fill in the correct Email Address');
            } else if (_passwordController.text.length < 4) {
              displayDialog(context, 'Invalid Password',
                  'The Password should be at least 4 characters');
            } else if (_passwordConfirmationController.text !=
                _passwordController.text) {
              displayDialog(context, 'Incorrect Password',
                  'Please check your Password and Confirmation Password');
            } else {
              displayDialog(context, 'Invalid Credentials',
                  'The account with this credential was created. Please create a new one');
            }
          });
    }

    return SafeArea(
      child: Scaffold(
        body: SignUpBackground(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 100, left: 65, right: 65),
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
                        passwordConfirmationInput(),
                        /* TODO: TO BE MOVED ASAP! */
                        Container(
                          height: 50,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            top: 25,
                          ),
                          child: ElevatedButton(
                              onPressed: _isLoading ? null : () => _submit(),
                              /* 
                                  () async {
                                      var name = _usernameController.text;
                                      var email = _emailController.text;
                                      var password = _passwordController.text;
                                      var passwordConfirmation =
                                          _passwordConfirmationController.text;

                                      if (name.length < 4) {
                                        displayDialog(
                                            context,
                                            "Invalid Username",
                                            "The username should be at least 4 characters long");
                                      } else if (password.length < 4)
                                        displayDialog(
                                            context,
                                            "Invalid Password",
                                            "The password should be at least 4 characters long");
                                      else {
                                        var res = await attemptSignUp(
                                            name,
                                            email,
                                            password,
                                            passwordConfirmation);
                                        if (res == 201) {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      BottomNavigation()));
                                          displayDialog(context, "Success",
                                              "The user was created! You are now logged in!");
                                        } else if (res == 409)
                                          displayDialog(
                                              context,
                                              "That username is already registered",
                                              "Please try to sign up using another username or log in if you already have an account.");
                                        else {
                                          displayDialog(
                                              context,
                                              "That username is already registered",
                                              "Please try to sign up using another username or log in if you already have an account.");
                                        }
                                      }
                                    },
                                    */
                              child: Text(
                                _isLoading ? 'Creating...' : 'Sign Up',
                                style: whiteTextStyle.copyWith(fontSize: 16),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        whiteColor),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        darkPurpleColor),
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
