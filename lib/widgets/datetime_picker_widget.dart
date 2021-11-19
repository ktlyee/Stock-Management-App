import 'package:csc344_project/notifier/solditem_notifier.dart';
import 'package:csc344_project/widgets/show_datetime.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DatePickerWidget extends StatefulWidget {
  DatePickerWidget({Key? key}) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime date = DateTime.now();

  String getText() {
    return DateFormat('dd MMM y').format(date);
  }

  @override
  Widget build(BuildContext context) {
    SoldItemsNotifier soldItemsNotifier =
        Provider.of<SoldItemsNotifier>(context);

    return ShowDateTime(
      text: getText(),
      onClicked: () => pickDate(context, soldItemsNotifier),
    );
  }

  Future pickDate(
    BuildContext context,
    SoldItemsNotifier soldItemsNotifier,
  ) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;

    setState(() {
      date = newDate;
      soldItemsNotifier.date = getText();
    });
  }
}
