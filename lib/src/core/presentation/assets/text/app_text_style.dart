import 'package:flutter/cupertino.dart';

enum AppTextStyleEnum {
  statisticText(
    TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
  ),
  addNoteText(TextStyle(
    fontSize: 20,
  )),
  addNoteHintText(TextStyle(
    fontSize: 15,
  ));

  const AppTextStyleEnum(this.style);

  final TextStyle style;
}
