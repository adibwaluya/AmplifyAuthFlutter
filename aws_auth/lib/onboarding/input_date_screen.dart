import 'package:aws_auth/widgets/bottom_navigation.dart';
import 'package:aws_auth/widgets/date_picker_widget.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class InputDateScreen extends StatefulWidget {
  const InputDateScreen({Key? key}) : super(key: key);

  @override
  _InputDateScreenState createState() => _InputDateScreenState();
}

class _InputDateScreenState extends State<InputDateScreen> {
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return BottomNavigation();
                    }),
                  );
                },
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
