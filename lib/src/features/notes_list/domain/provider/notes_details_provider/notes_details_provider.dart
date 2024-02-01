import 'package:daylio_clone/src/features/notes_list/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes_list/domain/entity/food_model.dart';
import 'package:daylio_clone/src/features/notes_list/domain/entity/grade_label.dart';
import 'package:daylio_clone/src/features/notes_list/domain/entity/sleep_model.dart';
import 'package:daylio_clone/src/features/notes_list/domain/entity/mood_model.dart';
import 'package:daylio_clone/src/features/notes_list/domain/entity/note_model.dart';
import 'package:daylio_clone/src/features/notes_list/domain/entity/note_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotesDetailsProvider extends ChangeNotifier {
  final NotesRepository _notesRepository;
  final int _id;
  NoteState state = NoteState(
      note: NoteModel(
          id: 0,
          mood: MoodModel.empty(),
          sleep: SleepModel.empty(),
          food: FoodModel.empty(),
          date: DateTime.now()),
      activeMoodId: 0);
  String day = '';
  String time = '';

  NotesDetailsProvider({
    required NotesRepository notesRepository,
    required int id,
  })  : _notesRepository = notesRepository,
        _id = id {
    readNote();
  }

  Future<void> readNote() async {
    try {
      final note = await _notesRepository.readNote(_id);
      state = state.copyWith(note: note, activeMoodId: note.mood.id);
      day = DateFormat('dd.MM.yyyy').format(state.note.date);
      time = DateFormat('HH:mm').format(state.note.date);
      notifyListeners();
    } on Object {
      rethrow;
    }
  }

  Future<void> updateNote() async {
    try {
      await _notesRepository.updateNote(state.note);
    } on Object {
      rethrow;
    }
  }

  Future<void> setDate(DateTime dateTime) async {
    day = DateFormat('dd.MM.yyyy').format(dateTime);
    updateDate();
  }

  Future<void> setTime(TimeOfDay selectedTime) async {
    time = '${selectedTime.hour}:${selectedTime.minute}';
    updateDate();
  }

  Future<void> updateFoodDescription(String text) async {
    state = state.copyWith(
        note: state.note
            .copyWith(food: state.note.food.copyWith(description: text)));
  }

  Future<void> updateSleepDescription(String text) async {
    state = state.copyWith(
        note: state.note
            .copyWith(sleep: state.note.sleep.copyWith(description: text)));
  }

  Future<void> updateSleepGrade(GradeLabel? value) async {
    if (value != null) {
      state = state.copyWith(
          note: state.note
              .copyWith(sleep: state.note.sleep.copyWith(id: value.index)));
      state = state.copyWith(
          note: state.note
              .copyWith(sleep: state.note.sleep.copyWith(title: value.title)));

      state = state.copyWith(
          note: state.note
              .copyWith(sleep: state.note.sleep.copyWith(color: value.color)));
    }
  }

  Future<void> updateFoodGrade(GradeLabel? value) async {
    if (value != null) {
      state = state.copyWith(
          note: state.note
              .copyWith(food: state.note.food.copyWith(id: value.index)));
      state = state.copyWith(
          note: state.note
              .copyWith(food: state.note.food.copyWith(title: value.title)));
      state = state.copyWith(
          note: state.note
              .copyWith(food: state.note.food.copyWith(color: value.color)));
    }
  }

  Future<void> updateDate() async {
    DateFormat format = DateFormat('dd.MM.yyyy HH:mm');
    DateTime date = format.parse('$day $time');
    state = state.copyWith(note: state.note.copyWith(date: date));
  }

  Future<void> setActiveMood(int id) async {
    state = state.copyWith(activeMoodId: id);
    state = state.copyWith(
        note: state.note.copyWith(mood: state.moods[state.activeMoodId]));
  }
}
