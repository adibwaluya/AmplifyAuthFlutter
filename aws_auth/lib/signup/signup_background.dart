import 'package:flutter/material.dart';

class SignUpBackground extends StatelessWidget {
  final Widget child;
  const SignUpBackground({Key? key, required this.child}) : super(key: key);

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
            right: 0,
            child: Image.asset("assets/shapes/lightBlue_rectangle_signup.png",
                width: size.width * 0.25),
          ),
          Positioned(
            top: 0,
            right: 97,
            child: Image.asset("assets/shapes/blue_rectangle_signup.png",
                width: size.width * 0.15),
          ),
          Positioned(
            top: 111,
            right: 0,
            child: Image.asset("assets/shapes/darkBlue_rectangle_signup.png",
                width: size.width * 0.17),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset("assets/shapes/lightBlue_ellipse_signup.png",
                width: size.width * 0.3),
          ),
          child,
        ],
      ),
    );
  }
}
