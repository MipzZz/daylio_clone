import 'package:flutter/material.dart';

sealed class NoteDetailsEvents {
  const NoteDetailsEvents();
}

final class NoteDetailsLoadNoteEvent implements NoteDetailsEvents {
  final int noteId;
  const NoteDetailsLoadNoteEvent(this.noteId);
}

final class NoteDetailsDateChangeEvent implements NoteDetailsEvents {
  final DateTime date;
  const NoteDetailsDateChangeEvent(this.date);
}

final class NoteDetailsTimeChangeEvent implements NoteDetailsEvents {
  final TimeOfDay time;
  const NoteDetailsTimeChangeEvent(this.time);
}

final class NoteDetailsMoodChangeEvent implements NoteDetailsEvents {
  final int moodId;
  const NoteDetailsMoodChangeEvent(this.moodId);
}

final class NoteDetailsSleepChangeGradeEvent implements NoteDetailsEvents {
  final int sleepId;
  const NoteDetailsSleepChangeGradeEvent(this.sleepId);
}

final class NoteDetailsSleepChangeDescriptionEvent implements NoteDetailsEvents {
  final String sleepDescription;
  const NoteDetailsSleepChangeDescriptionEvent(this.sleepDescription);
}

final class NoteDetailsFoodChangeGradeEvent implements NoteDetailsEvents {
  final int foodId;
  const NoteDetailsFoodChangeGradeEvent(this.foodId);
}

final class NoteDetailsFoodChangeDescriptionEvent implements NoteDetailsEvents {
  final String foodDescription;
  const NoteDetailsFoodChangeDescriptionEvent(this.foodDescription);
}

final class NoteDetailsSaveEvent implements NoteDetailsEvents {
  const NoteDetailsSaveEvent();
}

final class NoteDetailsDeleteEvent implements NoteDetailsEvents {
  const NoteDetailsDeleteEvent();
}