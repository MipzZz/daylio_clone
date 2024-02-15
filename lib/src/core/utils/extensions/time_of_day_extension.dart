import 'package:flutter/material.dart';

extension NotesTimeOfDay on TimeOfDay{
  String timeOnly() => '$hour:$minute';
}
