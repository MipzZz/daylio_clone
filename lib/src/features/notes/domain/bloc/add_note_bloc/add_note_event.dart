import 'package:flutter/material.dart';

sealed class AddNoteEvent {
  const AddNoteEvent();
}

final class AddNoteEvent$DateChange implements AddNoteEvent {
  const AddNoteEvent$DateChange(this.date);
  final DateTime date;
}

final class AddNoteEvent$TimeChange implements AddNoteEvent {
  const AddNoteEvent$TimeChange(this.time);
  final TimeOfDay time;
}

final class AddNoteEvent$MoodChange implements AddNoteEvent {
  const AddNoteEvent$MoodChange(this.moodId);
  final int moodId;
}

final class AddNoteEvent$SleepGradeChange implements AddNoteEvent {
  const AddNoteEvent$SleepGradeChange(this.sleepId);
  final int sleepId;
}

final class AddNoteEvent$SleepDescriptionChange implements AddNoteEvent {

  const AddNoteEvent$SleepDescriptionChange(this.sleepDescription);
  final String sleepDescription;
}

final class AddNoteEvent$FoodGradeChange implements AddNoteEvent {
  const AddNoteEvent$FoodGradeChange(this.foodId);
  final int foodId;
}

final class AddNoteEvent$FoodDescriptionChange implements AddNoteEvent {

  const AddNoteEvent$FoodDescriptionChange(this.foodDescription);
  final String foodDescription;
}

final class AddNoteEvent$Submit implements AddNoteEvent {}
