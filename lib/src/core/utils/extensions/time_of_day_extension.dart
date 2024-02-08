import 'package:flutter/material.dart';

extension NotesTimeOfDay on TimeOfDay{
  String timeOnly() => '${(this).hour}:${(this).minute}';
}