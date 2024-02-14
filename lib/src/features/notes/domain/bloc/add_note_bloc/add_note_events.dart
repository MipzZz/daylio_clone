import 'package:flutter/material.dart';

sealed class AddNoteEvent {
  const AddNoteEvent();
}

final class AddNoteDateChangeEvent implements AddNoteEvent {
  final DateTime date;
  const AddNoteDateChangeEvent(this.date);
}

final class AddNoteTimeChangeEvent implements AddNoteEvent {
  final TimeOfDay time;
  const AddNoteTimeChangeEvent(this.time);
}

final class AddNoteMoodChangeEvent implements AddNoteEvent {
  final int moodId;
  const AddNoteMoodChangeEvent(this.moodId);
}

final class AddNoteSleepChangeGradeEvent implements AddNoteEvent {
  final int sleepId;
  const AddNoteSleepChangeGradeEvent(this.sleepId);
}

final class AddNoteSleepChangeDescriptionEvent implements AddNoteEvent {
  final String sleepDescription;

  const AddNoteSleepChangeDescriptionEvent(this.sleepDescription);
}

final class AddNoteFoodChangeGradeEvent implements AddNoteEvent {
  final int foodId;
  const AddNoteFoodChangeGradeEvent(this.foodId);
}

final class AddNoteFoodChangeDescriptionEvent implements AddNoteEvent {
  final String foodDescription;

  const AddNoteFoodChangeDescriptionEvent(this.foodDescription);
}

final class AddNoteSubmitEvent implements AddNoteEvent {}
