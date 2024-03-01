import 'package:daylio_clone/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension NotesDateTime on DateTime {
  String dateOnly() => DateFormat('dd.MM.yyyy').format(this);
  String toTimeOnly() => DateFormat('HH:mm').format(this);
  String toHeaderDate() => DateFormat.MMMMEEEEd('ru-RU').format(this).capitalize();
  TimeOfDay toTimeOfDay() => TimeOfDay.fromDateTime(this);
  DateTime withoutTime() => DateTime(year, month, day);
  DateTime endOfDay() => DateTime(year, month, day, 23, 59, 59);
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) => year == other.year && month == other.month
        && day == other.day;
}
