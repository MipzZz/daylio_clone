import 'package:flutter/material.dart';

sealed class AddNoteEvent {
  const AddNoteEvent();
}

final class AddNoteEvent$DateChange implements AddNoteEvent {
  final DateTime date;
  const AddNoteEvent$DateChange(this.date);
}

final class AddNoteEvent$TimeChange implements AddNoteEvent {
  final TimeOfDay time;
  const AddNoteEvent$TimeChange(this.time);
}

final class AddNoteEvent$MoodChange implements AddNoteEvent {
  final int moodId;
  const AddNoteEvent$MoodChange(this.moodId);
}

final class AddNoteEvent$SleepGradeChange implements AddNoteEvent {
  final int sleepId;
  const AddNoteEvent$SleepGradeChange(this.sleepId);
}

final class AddNoteEvent$SleepDescriptionChange implements AddNoteEvent {
  final String sleepDescription;

  const AddNoteEvent$SleepDescriptionChange(this.sleepDescription);
}

final class AddNoteEvent$FoodGradeChange implements AddNoteEvent {
  final int foodId;
  const AddNoteEvent$FoodGradeChange(this.foodId);
}

final class AddNoteEvent$FoodDescriptionChange implements AddNoteEvent {
  final String foodDescription;

  const AddNoteEvent$FoodDescriptionChange(this.foodDescription);
}

final class AddNoteEvent$Submit implements AddNoteEvent {}
