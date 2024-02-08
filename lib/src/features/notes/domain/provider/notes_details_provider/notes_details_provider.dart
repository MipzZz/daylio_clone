import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/grade_label.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/mood_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';
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
      if (note.id == null) throw Exception(); //Из базы данных не может придти запись с null id
      state = NoteDetailsStateData(
        id: note.id ?? -1,
        mood: note.mood,
        food: note.food,
        sleep: note.sleep,
        date: note.date,
      );
      notifyListeners();
    } on Object catch (e, s) {
      state = NoteDetailsStateError(
        id: state.id,
        mood: state.mood,
        food: state.food,
        sleep: state.sleep,
        date: state.date,
        message: 'При загрузке данных произошла ошибка',
      );
      notifyListeners();
      Error.throwWithStackTrace(e, s);
    }
  }

  Future<void> updateNote() async {
    try {
      final note = NoteModel(
        id: state.id,
        mood: state.mood ?? moods[0], //ToDo Уточнить насколько верное решение
        food: state.food,
        sleep: state.sleep,
        date: state.date ?? DateTime.now(), //ToDo Тут тоже
      );
      if (note.id != null) {
        await _notesRepository.updateNote(note);
      }
      notifyListeners();
    } on Object catch (e, s) {
      state = NoteDetailsStateError(
        id: state.id,
        mood: state.mood,
        food: state.food,
        sleep: state.sleep,
        date: state.date,
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
        id: state.id,
        mood: state.mood,
        food: state.food,
        sleep: state.sleep,
        date: state.date,
        message: 'При удалении данных произошла ошибка',
      );
      notifyListeners();
      Error.throwWithStackTrace(e, s);
    }
  }

  void updateDate(DateTime date) {
    state = state.copyWith(
        date: state.date
            ?.copyWith(day: date.day, month: date.month, year: date.year));
    notifyListeners();
  }

  void updateTime(TimeOfDay time) {
    state = state.copyWith(
        date: state.date?.copyWith(hour: time.hour, minute: time.minute));
    notifyListeners();
  }

  Future<void> updateFoodDescription(String text) async {
    state = state.copyWith(food: state.food?.copyWith(description: text));
  }

  Future<void> updateSleepDescription(String text) async {
    state = state.copyWith(sleep: state.sleep?.copyWith(description: text));
  }

  Future<void> updateSleepGrade(GradeLabel? value) async {
    if (value == null) return;
    state = state.copyWith(
        sleep: state.sleep?.copyWith(
      id: value.index,
      title: value.title,
      color: value.color,
    ));
  }

  Future<void> updateFoodGrade(GradeLabel? value) async {
    if (value == null) return;
    state = state.copyWith(
        food: state.food?.copyWith(
      id: value.index,
      title: value.title,
      color: value.color,
    ));
  }

  Future<void> updateMood(int id) async {
    if (id == state.mood?.id) return;
    state = state.copyWith(
      mood: moods[id],
    );
    notifyListeners();
  }
}
