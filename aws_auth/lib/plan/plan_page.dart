import 'package:aws_auth/widgets/date_picker_widget.dart';
import 'package:aws_auth/widgets/date_range_picker.dart';
import 'package:flutter/material.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Center(child: DatePickerWidget())));
  }
}
