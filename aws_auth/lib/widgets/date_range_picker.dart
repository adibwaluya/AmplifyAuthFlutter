import 'package:aws_auth/widgets/button_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangePickerWidget extends StatefulWidget {
  const DateRangePickerWidget({Key? key}) : super(key: key);

  @override
  _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTimeRange? dateRange;

  String getFrom() {
    if (dateRange == null) {
      return 'From';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange!.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'Until';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange!.end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return HeaderWidget(
      title: 'Date Range',
      child: Row(
        children: [
          Expanded(
            child: ButtonWidget(
              text: getFrom(),
              onClicked: () {
                pickDateRange(context);
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(getUntil()),
          )
        ],
      ),
    );
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(const Duration(hours: 24 * 3)),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange ?? initialDateRange,
    );

    if (newDateRange == null) return;

    setState(() {
      dateRange = newDateRange;
    });
  }
}
