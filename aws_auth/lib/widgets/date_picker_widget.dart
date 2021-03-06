import 'package:aws_auth/utils/date_simple_preferences.dart';
import 'package:aws_auth/widgets/button_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({Key? key}) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  final storage = FlutterSecureStorage();
  DateTime? date;
  DateTime? endDate;
  String dateStartString = "";
  String dateEndString = "";
  String _dateEndString = "";

  @override
  void initstate() {
    super.initState();
    _loadDate();
  }

  _loadDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _dateEndString = (prefs.getString('addDateEnd') ?? "");
    });
  }

  _setDate(String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _dateEndString = date;
    });
    prefs.setString('addDateEnd', _dateEndString);
  }

  String getStartText() {
    if (date == null) {
      return 'Start of your study preparation';
    } else {
      dateStartString = DateFormat('dd/MM/yyyy').format(date!);
      _setStoredStartDate(dateStartString);
      return dateStartString;
    }
  }

  String getEndText() {
    if (date == null) {
      return 'End of your study preparation';
    } else {
      dateEndString = DateFormat('dd/MM/yyyy').format(endDate!);
      _setStoredEndDate(dateEndString);
      _setDatePreference(dateEndString);
      //_setDatePreference(endDate!);
      return dateEndString;
    }
  }

  void _setStoredStartDate(String date) async {
    await storage.write(key: 'dateStart', value: date);
  }

  void _setStoredEndDate(String date) async {
    await storage.write(key: 'dateEnd', value: date);
    //DateSimplePreferences.setEndDate(date);
  }

  void _setDatePreference(String date) async {
    DateSimplePreferences.setEndDate(date);
    /* final prefs = await SharedPreferences.getInstance();
    final updatedEndDate = prefs.setString('dateEndPref', date); */
  }

  @override
  Widget build(BuildContext context) {
    return ButtonHeaderWidget(
      title: 'Date',
      text: getStartText(),
      endText: getEndText(),
      onClicked: () => pickDate(context),
    );
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: date ?? initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
    final newEndDate = newDate?.add(const Duration(hours: 24 * 190));
    // _setDatePreference(newEndDate);
    if (newDate == null) return;

    setState(() {
      date = newDate;
      endDate = newEndDate;
      _setDate(DateFormat('dd/MM/yyyy').format(endDate!));
      // _setDatePreference(endDate!.toIso8601String());
      //_setDatePreference(endDate!);
      //await DateSimplePreferences.setEndDate(endDate!);
      //DateSimplePreferences.setEndDate(dateEndString);
    });
  }
}
