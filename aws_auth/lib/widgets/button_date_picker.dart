import 'package:flutter/material.dart';

import '../theme.dart';

class ButtonHeaderWidget extends StatelessWidget {
  final String title;
  final String text;
  final String endText;
  final VoidCallback onClicked;
  const ButtonHeaderWidget(
      {Key? key,
      required this.title,
      required this.text,
      required this.onClicked,
      required this.endText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HeaderWidget(
      title: title,
      child: Column(
        children: [
          ButtonWidget(text: text, onClicked: onClicked),
          SizedBox(
            height: 30,
          ),
          Text('End of Study Preparation: '),
          Text(
            endText,
            style: blackSemiBoldTextStyle.copyWith(fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  const ButtonWidget({Key? key, required this.text, required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          foregroundColor: MaterialStateProperty.all<Color>(whiteColor),
          backgroundColor: MaterialStateProperty.all<Color>(darkPurpleColor),
        ),
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        onPressed: onClicked,
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  final String title;
  final Widget child;
  const HeaderWidget({Key? key, required this.title, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        child,
      ],
    );
  }
}
