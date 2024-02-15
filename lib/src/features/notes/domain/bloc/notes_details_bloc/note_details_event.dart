import 'package:flutter/material.dart';

sealed class NoteDetailsEvent {
  const NoteDetailsEvent();
}

final class NoteDetailsEvent$LoadNote implements NoteDetailsEvent {
  final int noteId;
  const NoteDetailsEvent$LoadNote(this.noteId);
}

final class NoteDetailsEvent$DateChange implements NoteDetailsEvent {
  final DateTime date;
  const NoteDetailsEvent$DateChange(this.date);
}

final class NoteDetailsEvent$TimeChange implements NoteDetailsEvent {
  final TimeOfDay time;
  const NoteDetailsEvent$TimeChange(this.time);
}

final class NoteDetailsEvent$MoodChange implements NoteDetailsEvent {
  final int moodId;
  const NoteDetailsEvent$MoodChange(this.moodId);
}

final class NoteDetailsEvent$SleepGradeChange implements NoteDetailsEvent {
  final int sleepId;
  const NoteDetailsEvent$SleepGradeChange(this.sleepId);
}

final class NoteDetailsEvent$SleepDescriptionChange implements NoteDetailsEvent {
  final String sleepDescription;
  const NoteDetailsEvent$SleepDescriptionChange(this.sleepDescription);
}

final class NoteDetailsEvent$FoodGradeChange implements NoteDetailsEvent {
  final int foodId;
  const NoteDetailsEvent$FoodGradeChange(this.foodId);
}

final class NoteDetailsEvent$FoodDescriptionChange implements NoteDetailsEvent {
  final String foodDescription;
  const NoteDetailsEvent$FoodDescriptionChange(this.foodDescription);
}

final class NoteDetailsEvent$Save implements NoteDetailsEvent {
  const NoteDetailsEvent$Save();
}

final class NoteDetailsEvent$Delete implements NoteDetailsEvent {
  const NoteDetailsEvent$Delete();
}