import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/grade_label.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/mood_model.dart';
import 'package:daylio_clone/src/features/notes/domain/provider/add_note_provider/add_note_state.dart';
import 'package:flutter/material.dart';

class AddNoteProvider {
  final NotesRepository _notesRepository;
  AddNoteState state;
  List<MoodModel> moods;

  AddNoteProvider({
    required NotesRepository notesRepository,
  })  : _notesRepository = notesRepository,
        state = AddNoteStateInitial(),
        moods = notesRepository.getMoods() {
    state = state.copyWith(
      note: state.note?.copyWith(
        mood: moods[0],
      ),
    );
  }

  Future<void> saveMood(int id) async {
    state = state.copyWith(
      note: state.note?.copyWith(
        mood: moods[id],
      ),
    );
  }

  void saveDate(DateTime date) {
    state = state.copyWith(
        note: state.note?.copyWith(
            date: state.note?.date
                .copyWith(day: date.day, month: date.month, year: date.year)));
  }

  Future<void> saveTime(TimeOfDay time) async {
    state = state.copyWith(
        note: state.note?.copyWith(
            date: state.note?.date
                .copyWith(hour: time.hour, minute: time.minute)));
  }

  Future<void> saveNote() async {
    try {
      final note = state.note;
      if (note != null && note.id == null) {
        await _notesRepository.saveNote(note);
      }
    } on Object catch (e, s) {
      state = AddNoteStateError(
        note: state.note,
        message: 'При сохранении данных произошла ошибка',
      );
      Error.throwWithStackTrace(e, s);
    }
  }

  Future<void> saveSelectedSleep(GradeLabel? value) async {
    if (value != null) {
      state = state.copyWith(
        note: state.note?.copyWith(
          sleep: state.note?.sleep.copyWith(
            id: value.index,
            title: value.title,
            color: value.color,
          ),
        ),
      );
    }
  }

  Future<void> saveSelectedFood(GradeLabel? value) async {
    if (value != null) {
      state = state.copyWith(
        note: state.note?.copyWith(
          food: state.note?.food.copyWith(
            id: value.index,
            title: value.title,
            color: value.color,
          ),
        ),
      );
    }
  }

  Future<void> saveFoodDescription(String text) async {
    state = state.copyWith(
        note: state.note
            ?.copyWith(food: state.note?.food.copyWith(description: text)));
  }

  Future<void> saveSleepDescription(String text) async {
    state = state.copyWith(
        note: state.note
            ?.copyWith(sleep: state.note?.sleep.copyWith(description: text)));
  }
}
