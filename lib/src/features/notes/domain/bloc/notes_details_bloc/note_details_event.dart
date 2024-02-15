import 'package:flutter/material.dart';

sealed class NoteDetailsEvent {
  const NoteDetailsEvent();
}

final class NoteDetailsEvent$LoadNote implements NoteDetailsEvent {
  const NoteDetailsEvent$LoadNote(this.noteId);
  final int noteId;
}

final class NoteDetailsEvent$DateChange implements NoteDetailsEvent {
  const NoteDetailsEvent$DateChange(this.date);
  final DateTime date;
}

final class NoteDetailsEvent$TimeChange implements NoteDetailsEvent {
  const NoteDetailsEvent$TimeChange(this.time);
  final TimeOfDay time;
}

final class NoteDetailsEvent$MoodChange implements NoteDetailsEvent {
  const NoteDetailsEvent$MoodChange(this.moodId);
  final int moodId;
}

final class NoteDetailsEvent$SleepGradeChange implements NoteDetailsEvent {
  const NoteDetailsEvent$SleepGradeChange(this.sleepId);
  final int sleepId;
}

final class NoteDetailsEvent$SleepDescriptionChange implements NoteDetailsEvent {
  const NoteDetailsEvent$SleepDescriptionChange(this.sleepDescription);
  final String sleepDescription;
}

final class NoteDetailsEvent$FoodGradeChange implements NoteDetailsEvent {
  const NoteDetailsEvent$FoodGradeChange(this.foodId);
  final int foodId;
}

final class NoteDetailsEvent$FoodDescriptionChange implements NoteDetailsEvent {
  const NoteDetailsEvent$FoodDescriptionChange(this.foodDescription);
  final String foodDescription;
}

final class NoteDetailsEvent$Save implements NoteDetailsEvent {
  const NoteDetailsEvent$Save();
}

final class NoteDetailsEvent$Delete implements NoteDetailsEvent {
  const NoteDetailsEvent$Delete();
}
