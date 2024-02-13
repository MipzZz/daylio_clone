import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension NotesDateTime on DateTime {
  String dateOnly() => DateFormat('dd.MM.yyyy').format(this);
  TimeOfDay toTimeOfDay() => TimeOfDay.fromDateTime(this);
}
