import 'package:aws_auth/auth/auth.dart';
import 'package:aws_auth/feed/feed_page.dart';
import 'package:aws_auth/signin/signin_background.dart';
import 'package:aws_auth/signup/signup_page.dart';
import 'package:aws_auth/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../theme.dart';

const SERVER_IP = 'http://192.168.42.75:8000';
final storage = FlutterSecureStorage();

class SignInPage extends StatefulWidget {
  /* Commented for testing purpose
     12.10.2021
  
  final ValueChanged<LoginCredentials> didProvideCredentials;
  */
  // final VoidCallback shouldShowSignUp;

  const SignInPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(text),
        ),
      );

  Future<String?> attemptSignIn(String email, String password) async {
    var res = await http.post(
        Uri.parse('http://192.168.42.75:8000/api/auth/login'),
        body: {"email": email, "password": password});
    var jsonResponse = null;
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
      return res.body;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    //TextEditingController _emailController = new TextEditingController();
    //TextEditingController _passwordController = new TextEditingController();

/*
    attemptLogIn(String email, password) async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      Map data = {'email': email, 'password': password};
      var jsonResponse = null;

      var res = await http
          .post(Uri.parse("http://192.168.42.75:8000/api/login"), body: data);
      if (res.statusCode == 200) {
        jsonResponse = json.decode(res.body);
        print('Response status: ${res.statusCode}');
        print('Response body: ${res.body}');
        if (jsonResponse != null) {
          setState(() {
            _isLoading = false;
          });
          sharedPreferences.setString("token", jsonResponse['token']);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => FeedPage()),
              (Route<dynamic> route) => false);
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        print(res.body);
      }
    }
*/
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
                    "assets/icons/Avatar_icon.png",
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
                      hintText: 'Username',
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

/*
    Widget buttonSelection() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(
          top: 25,
        ),
        child: ElevatedButton(
            onPressed: () async {
              var email = _emailController.text;
              var password = _passwordController.text;

              var jwt = await attemptSignIn(email, password);
              if (jwt != null) {
                storage.write(key: "jwt", value: jwt);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FeedPage.fromBase64(jwt)));
              } else {
                displayDialog(context, "An Error Occured",
                    "No Account was found matching that email and password");
              }
            },
            child: Text(
              "Sign in",
              style: whiteTextStyle.copyWith(fontSize: 16),
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              foregroundColor: MaterialStateProperty.all<Color>(whiteColor),
              backgroundColor:
                  MaterialStateProperty.all<Color>(darkPurpleColor),
            )),
      );
    }
*/
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();

      super.dispose();
    }

    void _submit() {
      Provider.of<Auth>(context, listen: false).signin(
          data: {
            'email': _emailController.text,
            'password': _passwordController.text
          },
          success: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return BottomNavigation();
            }));
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Login Successful")));
          },
          error: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Invalid Credentials")));
          });
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
      child: Scaffold(body: Center(
        child: Consumer<Auth>(
          builder: (context, auth, child) {
            if (auth.loggedIn) {
              return const BottomNavigation();
            } else {
              return SignInBackground(
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView(children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 100, left: 65, right: 65),
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
                                style: blackSemiBoldTextStyle.copyWith(
                                    fontSize: 30),
                              ),
                              emailInput(),
                              passwordInput(),
                              /* TODO: TO BE MOVED ASAP! */
                              /*
                  Container(
                    height: 50,
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      top: 25,
                    ),
                    child: ElevatedButton(
                        onPressed: _emailController.text == "" ||
                                _passwordController.text == ""
                            ? null
                            : () {
                                setState(() {
                                  _isLoading = true;
                                });
                                attemptLogIn(_emailController.text,
                                    _passwordController.text);
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
                  */
                              ElevatedButton(
                                  onPressed: () => _submit(),
                                  child: Text(
                                    "Sign in",
                                    style:
                                        whiteTextStyle.copyWith(fontSize: 16),
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
                              createAccount(),
                            ],
                          ),
                        ),
                      ]),
              );
            }
          },
        ),
      )),
    );
  }
}
