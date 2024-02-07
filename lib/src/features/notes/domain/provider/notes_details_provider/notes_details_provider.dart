import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/grade_label.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/mood_model.dart';
import 'package:daylio_clone/src/features/notes/domain/provider/notes_details_provider/note_details_state.dart';
import 'package:flutter/material.dart';

class NotesDetailsProvider extends ChangeNotifier {
  final NotesRepository _notesRepository;
  NoteDetailsState state;
  List<MoodModel> moods;

  NotesDetailsProvider({
    required NotesRepository notesRepository,
    required int id,
  })  : _notesRepository = notesRepository,
        state = NoteDetailsStateInitial(),
        moods = notesRepository.getMoods() {
    readNote(id);
  }

  Future<void> readNote(int id) async {
    try {
      final note = await _notesRepository.readNote(id);
      state = NoteDetailsStateData(note: note);
      notifyListeners();
    } on Object catch (e, s) {
      state = NoteDetailsStateError(
        note: state.note,
        message: 'При загрузке данных произошла ошибка',
      );
      notifyListeners();
      Error.throwWithStackTrace(e, s);
    }
  }

  Future<void> updateNote() async {
    try {
      final note = state.note;
      if (note != null && note.id != null) {
        await _notesRepository.updateNote(note);
      }
      notifyListeners();
    } on Object catch (e, s) {
      state = NoteDetailsStateError(
        note: state.note,
        message: 'При сохранении данных произошла ошибка',
      );
      notifyListeners();
      Error.throwWithStackTrace(e, s);
    }
  }

  Future<void> deleteNote({required int id}) async {
    try {
      await _notesRepository.deleteNote(id);
      notifyListeners();
    } on Object catch (e, s) {
      state = NoteDetailsStateError(
        note: state.note,
        message: 'При удалении данных произошла ошибка',
      );
      notifyListeners();
      Error.throwWithStackTrace(e, s);
    }
  }

  void updateDate(DateTime date) {
    state = state.copyWith(
        note: state.note?.copyWith(
            date: state.note?.date
                .copyWith(day: date.day, month: date.month, year: date.year)));
    notifyListeners();
  }

  void updateTime(TimeOfDay time) {
    state = state.copyWith(
        note: state.note?.copyWith(
            date: state.note?.date
                .copyWith(hour: time.hour, minute: time.minute)));
    notifyListeners();
  }

  Future<void> updateFoodDescription(String text) async {
    state = state.copyWith(
      note: state.note?.copyWith(
        food: state.note?.food?.copyWith(description: text),
      ),
    );
  }

  Future<void> updateSleepDescription(String text) async {
    state = state.copyWith(
      note: state.note?.copyWith(
        sleep: state.note?.sleep?.copyWith(description: text),
      ),
    );
  }

  Future<void> updateSleepGrade(GradeLabel? value) async {
    if (value != null) {
      state = state.copyWith(
        note: state.note?.copyWith(
          sleep: state.note?.sleep?.copyWith(
            id: value.index,
            title: value.title,
            color: value.color,
          ),
        ),
      );
    }
  }

  Future<void> updateFoodGrade(GradeLabel? value) async {
    if (value != null) {
      state = state.copyWith(
        note: state.note?.copyWith(
          food: state.note?.food?.copyWith(
            id: value.index,
            title: value.title,
            color: value.color,
          ),
        ),
      );
    }
  }

  Future<void> updateMood(int id) async {
    if (id == state.note?.mood.id) return;
    state = state.copyWith(
      note: state.note?.copyWith(
        mood: moods[id],
      ),
    );
    notifyListeners();
  }
}
