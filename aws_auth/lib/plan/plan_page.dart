import 'package:aws_auth/auth/auth.dart';
import 'package:aws_auth/model/checkbox_state.dart';
import 'package:aws_auth/utils/date_simple_preferences.dart';
import 'package:aws_auth/widgets/date_picker_widget.dart';
import 'package:aws_auth/widgets/date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({Key? key}) : super(key: key);

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  bool? _checked = false;
  bool _isLoading = false;
  String dateEndString = "";
  String dateEndPref = "";
  var newDate;
  final storage = FlutterSecureStorage();

  void _getDatePreference() {
    DateSimplePreferences.getEnddate();
  }

  Future<String> getDateFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final updatedEndDate = prefs.getString('dateEndPref');
    _getDatePreference();
    if (updatedEndDate == null) {
      return 'no data';
    }
    return updatedEndDate;
  }

  Future<void> showDateFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    String lastEndDate = await getDateFromSharedPref();
    if (lastEndDate == null) {
      setState(() {
        Consumer<Auth>(
          builder: (context, auth, child) {
            if (auth.loggedIn) {
              return Text(
                auth.user.dateEnd,
                style: blackSemiBoldTextStyle.copyWith(fontSize: 25),
              );
            }
            /* setState(() {
                                this.dateEndString = dateEndString;
                              }); */
            return Text('No data');
          },
        );
      });
    } else {
      setState(() {
        dateEndString = lastEndDate;
      });
    }
  }

  _loadDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      dateEndString = (prefs.getString('addDateEnd') ?? '');
    });
  }

  _testLoadDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      dateEndPref = (prefs.getString('addDateEnd') ?? '');
    });
  }

  @override
  void initState() {
    super.initState();

    _loadDate();
    _testLoadDate();
  }

  final firstTodolists = [
    CheckBoxState(title: 'Register to a language course'),
    CheckBoxState(title: 'Taking Exam to earn the language certificate'),
    CheckBoxState(title: 'Earn the language certificate'),
  ];
  final secondTodolists = [
    CheckBoxState(title: 'Copy the necessary documents'),
    CheckBoxState(title: 'Translate all the documents'),
    CheckBoxState(title: 'Certify the documents'),
  ];
  final thirdTodolists = [
    CheckBoxState(title: 'Create your Bank Account'),
  ];
  final fourthTodolists = [
    CheckBoxState(title: 'Apply for Visa'),
    CheckBoxState(title: 'Collect your Visa from the embassy'),
  ];
  final fifthTodolists = [
    CheckBoxState(title: 'Apply for entrance examination (ANP)'),
    CheckBoxState(
        title:
            'Receive the admission for the entrance examination (Zulassung)'),
  ];
  final sixthTodolists = [
    CheckBoxState(title: 'Buy Plane Ticket'),
    CheckBoxState(title: 'Depart to Germany'),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              child: Image.asset(
                'assets/shapes/Ellipse_planning_bg.png',
                width: size.width * 1,
              ),
            ),
            ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 24.0),
                      child: Image.asset(
                        'assets/images/Planning_image.png',
                        width: size.width * 0.7,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Study Planning',
                            style: blackSemiBoldTextStyle.copyWith(
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Step-By-Step mempersiapkan Studi ke Jerman tepat waktu dengan time management',
                            style: blackRegularTextStyle.copyWith(fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Your Todolists',
                            style: blackSemiBoldTextStyle.copyWith(
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            'Your Preparation should be done on: ',
                            style: blackRegularTextStyle.copyWith(fontSize: 16),
                          ),
                          Text(
                            dateEndString,
                            style:
                                blackSemiBoldTextStyle.copyWith(fontSize: 25),
                          ),
                          /* Consumer<Auth>(
                            builder: (context, auth, child) {
                              if (auth.loggedIn) {
                                return Text(
                                  auth.user.dateEnd,
                                  style: blackSemiBoldTextStyle.copyWith(
                                      fontSize: 25),
                                );
                              }
                              /* setState(() {
                                this.dateEndString = dateEndString;
                              }); */
                              return Text('No data');
                            },
                          ), */
                          /* Consumer<Auth>(builder: (context, auth, child) {
                            if (auth.loggedIn) {
                              _getStoredEndDate();
                              return Text(
                                newDate,
                                style: blackSemiBoldTextStyle.copyWith(
                                    fontSize: 25),
                              );
                            } else if (!auth.loggedIn) {
                              _getStoredEndDate();
                              return Text(newDate);
                            }
                            return Text('No data');
                          }), */
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                leading: Image.asset(
                                  'assets/icons/planning_language_icon.png',
                                  width: size.width * 0.12,
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Language Course',
                                      style: blackSemiBoldTextStyle.copyWith(
                                          fontSize: 18),
                                    ),
                                    Text(
                                      'Register, Examination, Certificate',
                                      style: blackRegularTextStyle.copyWith(
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                children: [
                                  ...firstTodolists
                                      .map(buildSingleCheckbox)
                                      .toList(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                leading: Image.asset(
                                  'assets/icons/planning_document_icon.png',
                                  width: size.width * 0.12,
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Document Preparation',
                                      style: blackSemiBoldTextStyle.copyWith(
                                          fontSize: 18),
                                    ),
                                    Text(
                                      'Copy, Translate, and Certify all necessary documents',
                                      style: blackRegularTextStyle.copyWith(
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                children: [
                                  ...secondTodolists
                                      .map(buildSingleCheckbox)
                                      .toList(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                leading: Image.asset(
                                  'assets/icons/planning_bank_icon.png',
                                  width: size.width * 0.12,
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Bank Account',
                                      style: blackSemiBoldTextStyle.copyWith(
                                          fontSize: 18),
                                    ),
                                    Text(
                                      'Create a Bank Account',
                                      style: blackRegularTextStyle.copyWith(
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                children: [
                                  ...thirdTodolists
                                      .map(buildSingleCheckbox)
                                      .toList(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                leading: Image.asset(
                                  'assets/icons/planning_visa_icon.png',
                                  width: size.width * 0.12,
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Visa',
                                      style: blackSemiBoldTextStyle.copyWith(
                                          fontSize: 18),
                                    ),
                                    Text(
                                      'Apply and collect the visa',
                                      style: blackRegularTextStyle.copyWith(
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                children: [
                                  ...fourthTodolists
                                      .map(buildSingleCheckbox)
                                      .toList(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                leading: Image.asset(
                                  'assets/icons/planning_anp_icon.png',
                                  width: size.width * 0.12,
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Aufnahmeprüfung',
                                      style: blackSemiBoldTextStyle.copyWith(
                                          fontSize: 18),
                                    ),
                                    Text(
                                      'Apply and receive the admission for the entrance exam (ANP)',
                                      style: blackRegularTextStyle.copyWith(
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                children: [
                                  ...fifthTodolists
                                      .map(buildSingleCheckbox)
                                      .toList(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                leading: Image.asset(
                                  'assets/icons/planning_departure_icon.png',
                                  width: size.width * 0.12,
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Departure',
                                      style: blackSemiBoldTextStyle.copyWith(
                                          fontSize: 18),
                                    ),
                                    Text(
                                      'Buy the plane ticket and schedule your departure',
                                      style: blackRegularTextStyle.copyWith(
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                children: [
                                  ...sixthTodolists
                                      .map(buildSingleCheckbox)
                                      .toList(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 90,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }

  Widget buildTitle({required String title, required Widget child}) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: blackSemiBoldTextStyle.copyWith(fontSize: 25),
          ),
          SizedBox(height: 8.0),
          child,
        ],
      );

  Widget buildSingleCheckbox(CheckBoxState checkbox) => CheckboxListTile(
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        controlAffinity: ListTileControlAffinity.trailing,
        activeColor: greenColor,
        value: checkbox.value,
        title: Text(
          checkbox.title,
          style: blackRegularTextStyle.copyWith(fontSize: 12),
        ),
        onChanged: (value) => setState(() {
          checkbox.value = value!;
        }),
      );
}
