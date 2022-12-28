import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<String?> onSelectDate({
  required BuildContext context,
  bool isFromDate = false,
  bool isToDate = false,
  DateTime? selectedDate,
  Function(DateTime)? onDatePicked,
}) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: isFromDate
        ? (selectedDate ?? DateTime.now())
        : DateTime.now().subtract(
            Duration(days: DateTime.now().difference(selectedDate!).inDays)),
    firstDate: isFromDate
        ? DateTime(2020, 1)
        : DateTime.now().subtract(
            Duration(days: DateTime.now().difference(selectedDate!).inDays)),
    lastDate: DateTime.now(),
  );

  if (pickedDate != null) {
    onDatePicked?.call(pickedDate);
    return DateFormat("yyyy-MM-dd").format(pickedDate);
  }

  return null;
}
