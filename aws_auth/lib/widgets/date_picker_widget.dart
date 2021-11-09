import 'package:aws_auth/widgets/button_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

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
      return dateEndString;
    }
  }

  void _setStoredStartDate(String date) async {
    await storage.write(key: 'startDate', value: date);
  }

  void _setStoredEndDate(String date) async {
    await storage.write(key: 'endDate', value: date);
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
    final newEndDate = newDate!.add(const Duration(hours: 24 * 190));
    if (newDate == null) return;

    setState(() {
      date = newDate;
      endDate = newEndDate;
    });
  }
}
