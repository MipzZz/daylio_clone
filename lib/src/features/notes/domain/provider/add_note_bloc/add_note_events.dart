import 'package:flutter/material.dart';

sealed class AddNoteEvents {
  const AddNoteEvents();
}

class AddNoteDateChangeEvent implements AddNoteEvents {
  final DateTime date;
  const AddNoteDateChangeEvent(this.date);
}

class AddNoteTimeChangeEvent implements AddNoteEvents {
  final TimeOfDay time;
  const AddNoteTimeChangeEvent(this.time);
}

class AddNoteMoodChangeEvent implements AddNoteEvents {
  final int moodId;
  const AddNoteMoodChangeEvent(this.moodId);
}

class AddNoteSleepChangeGradeEvent implements AddNoteEvents {
  final int sleepId;
  const AddNoteSleepChangeGradeEvent(this.sleepId);
}

class AddNoteSleepChangeDescriptionEvent implements AddNoteEvents {
  final String sleepDescription;

  const AddNoteSleepChangeDescriptionEvent(this.sleepDescription);
}

class AddNoteFoodChangeGradeEvent implements AddNoteEvents {
  final int foodId;
  const AddNoteFoodChangeGradeEvent(this.foodId);
}

class AddNoteFoodChangeDescriptionEvent implements AddNoteEvents {
  final String foodDescription;

  const AddNoteFoodChangeDescriptionEvent(this.foodDescription);
}

class AddNoteSubmitEvent implements AddNoteEvents {}

