import 'package:aws_auth/auth/auth.dart';
import 'package:aws_auth/feed/feed_page.dart';
import 'package:aws_auth/widgets/bottom_navigation.dart';
import 'package:aws_auth/widgets/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class InputDateScreen extends StatefulWidget {
  const InputDateScreen({Key? key}) : super(key: key);

  @override
  _InputDateScreenState createState() => _InputDateScreenState();
}

class _InputDateScreenState extends State<InputDateScreen> {
  bool _isLoading = false;
  final storage = FlutterSecureStorage();

  void _updateSplashTwo() async {
    setState(() {
      _isLoading = true;
    });

    Provider.of<Auth>(context, listen: false).updateSplashTwo(
        data: {
          'is_splash_two': 1,
          'date_start': await storage.read(key: 'startDate'),
          'date_end': await storage.read(key: 'endDate'),
          'email': await storage.read(key: 'email'),
        },
        success: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) {
            return BottomNavigation();
          }), (route) => false);
        },
        error: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return InputDateScreen();
          }));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(children: [
            SizedBox(
              height: 100.0,
            ),
            Text(
              'The Start Date of your Study Preparation',
              style: blackSemiBoldTextStyle.copyWith(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            DatePickerWidget(),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: _isLoading ? null : () => _updateSplashTwo(),
                child: Text(
                  'Save Input Date',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
