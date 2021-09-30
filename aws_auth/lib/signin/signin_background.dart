import 'package:flutter/material.dart';

class SignInBackground extends StatelessWidget {
  final Widget child;
  const SignInBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset("assets/shapes/eclipse_login.png",
                width: size.width * 0.25),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/shapes/blue_rectangle_login.png",
                width: size.width * 0.25),
          ),
          Positioned(
            bottom: 0,
            right: 97,
            child: Image.asset("assets/shapes/lightPurple_rectangle_login.png",
                width: size.width * 0.15),
          ),
          child,
        ],
      ),
    );
  }
}
