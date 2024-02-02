import 'package:intl/intl.dart';

extension NOtesDateTime on DateTime {
  String dmyyyy() => DateFormat('dd.MM.yyyy').format(this);
}
