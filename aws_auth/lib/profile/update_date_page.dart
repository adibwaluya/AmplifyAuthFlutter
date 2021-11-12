import 'package:aws_auth/auth/auth.dart';
import 'package:aws_auth/profile/profile_page.dart';
import 'package:aws_auth/widgets/bottom_navigation.dart';
import 'package:aws_auth/widgets/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class UpdateDateScreen extends StatefulWidget {
  const UpdateDateScreen({Key? key}) : super(key: key);

  @override
  _UpdateDateScreenState createState() => _UpdateDateScreenState();
}

class _UpdateDateScreenState extends State<UpdateDateScreen> {
  bool _isLoading = false;
  final storage = FlutterSecureStorage();

  void _updateDatePrep() async {
    setState(() {
      _isLoading = true;
    });

    Provider.of<Auth>(context, listen: false).updateDate(
        data: {
          'date_start': await storage.read(key: 'dateStart'),
          'date_end': await storage.read(key: 'dateEnd'),
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
            return UpdateDateScreen();
          }));
        });
  }

  /* void _changeDate() async {
    await storage.read(key: 'dateEnd');
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: ListView(
          children: [
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
                onPressed: _isLoading ? null : () => _updateDatePrep(),
                child: Text(
                  'Save Input Date',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
