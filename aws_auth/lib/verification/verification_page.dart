import 'package:flutter/material.dart';

class VerficationPage extends StatefulWidget {
  final ValueChanged<String> didProvideVerificationCode;
  const VerficationPage({Key? key, required this.didProvideVerificationCode})
      : super(key: key);

  @override
  _VerficationPageState createState() => _VerficationPageState();
}

class _VerficationPageState extends State<VerficationPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
