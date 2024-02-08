import 'package:intl/intl.dart';

extension NotesDateTime on DateTime {
  String dateOnly() => DateFormat('dd.MM.yyyy').format(this);
}
