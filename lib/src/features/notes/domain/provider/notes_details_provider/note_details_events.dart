import 'package:flutter/material.dart';

sealed class NoteDetailsEvents {
  const NoteDetailsEvents();
}

class NoteDetailsLoadNoteEvent implements NoteDetailsEvents {
  final int noteId;
  const NoteDetailsLoadNoteEvent(this.noteId);
}

class NoteDetailsDateChangeEvent implements NoteDetailsEvents {
  final DateTime date;
  const NoteDetailsDateChangeEvent(this.date);
}

class NoteDetailsTimeChangeEvent implements NoteDetailsEvents {
  final TimeOfDay time;
  const NoteDetailsTimeChangeEvent(this.time);
}

class NoteDetailsMoodChangeEvent implements NoteDetailsEvents {
  final int moodId;
  const NoteDetailsMoodChangeEvent(this.moodId);
}

class NoteDetailsSleepChangeGradeEvent implements NoteDetailsEvents {
  final int sleepId;
  const NoteDetailsSleepChangeGradeEvent(this.sleepId);
}

class NoteDetailsSleepChangeDescriptionEvent implements NoteDetailsEvents {
  final String sleepDescription;
  const NoteDetailsSleepChangeDescriptionEvent(this.sleepDescription);
}

class NoteDetailsFoodChangeGradeEvent implements NoteDetailsEvents {
  final int foodId;
  const NoteDetailsFoodChangeGradeEvent(this.foodId);
}

class NoteDetailsFoodChangeDescriptionEvent implements NoteDetailsEvents {
  final String foodDescription;
  const NoteDetailsFoodChangeDescriptionEvent(this.foodDescription);
}

class NoteDetailsSaveEvent implements NoteDetailsEvents {
  const NoteDetailsSaveEvent();
}

class NoteDetailsDeleteEvent implements NoteDetailsEvents {
  const NoteDetailsDeleteEvent();
}