import 'package:daylio_clone/src/core/utils/exceptions/note_null_exception.dart';
import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/grade_label.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/mood_model.dart';
import 'package:daylio_clone/src/features/notes/domain/provider/notes_details_provider/note_details_state.dart';
import 'package:flutter/material.dart';

class NotesDetailsProvider extends ChangeNotifier {
  final NotesRepository _notesRepository;
  NoteDetailsState state;

  List<MoodModel> get moods => _notesRepository.getMoods();

  NotesDetailsProvider({
    required NotesRepository notesRepository,
    required int id,
  })  : _notesRepository = notesRepository,
        state = NoteDetailsStateInitial() {
    readNote(id);
  }

  Future<void> readNote(int id) async {
    try {
      final note = await _notesRepository.readNote(id);
      state = NoteDetailsStateData(
        note: note,
        date: note.date,
        moodId: note.mood.id,
        sleepId: note.sleep.id,
        sleepDescription: note.sleep.description,
        foodId: note.food.id,
        foodDescription: note.food.description,
      );
      notifyListeners();
    } on Object catch (e, s) {
      state = NoteDetailsStateError(
        date: state.date,
        moodId: state.moodId,
        sleepId: state.sleepId,
        sleepDescription: state.sleepDescription,
        foodId: state.foodId,
        foodDescription: state.foodDescription,
        message: 'При загрузке данных произошла ошибка',
      );
      notifyListeners();
      Error.throwWithStackTrace(e, s);
    }
  }

  void updateDate(DateTime date) {
    state = state.copyWith(
        date: state.date
            .copyWith(day: date.day, month: date.month, year: date.year));
    notifyListeners();
  }

  void updateTime(TimeOfDay time) {
    state = state.copyWith(
        date: state.date.copyWith(hour: time.hour, minute: time.minute));
    notifyListeners();
  }

  Future<void> updateMood(int id) async {
    if (id == state.moodId) return;
    state = state.copyWith(
      moodId: id,
    );
    notifyListeners();
  }

  Future<void> updateSleepGrade(int sleepId) async {
    state = state.copyWith(
      sleepId: sleepId,
    );
    notifyListeners();
  }

  Future<void> updateSleepDescription(String v) async {
    state = state.copyWith(sleepDescription: v);
    notifyListeners();
  }

  Future<void> updateFoodGrade(int foodId) async {
    state = state.copyWith(foodId: foodId);
    notifyListeners();
  }

  Future<void> updateFoodDescription(String v) async {
    state = state.copyWith(foodDescription: v);
    notifyListeners();
  }

  Future<void> updateNote() async {
    try {
      final note = state.note?.copyWith(
        date: state.date,
        mood: moods[state.moodId],
        sleep: state.note?.sleep.copyWith(
            id: state.sleepId,
            title: GradeLabel.values[state.sleepId].title,
            color: GradeLabel.values[state.sleepId].color,
            description: state.sleepDescription),
        food: state.note?.food.copyWith(
            id: state.foodId,
            title: GradeLabel.values[state.foodId].title,
            color: GradeLabel.values[state.foodId].color,
            description: state.foodDescription),
      );
      if (note == null) throw NoteNullException();
      await _notesRepository.updateNote(note);
      notifyListeners();
    } on Object catch (e, s) {
      state = NoteDetailsStateError(
        date: state.date,
        moodId: state.moodId,
        sleepId: state.sleepId,
        sleepDescription: state.sleepDescription,
        foodId: state.foodId,
        foodDescription: state.foodDescription,
        message: 'При сохранении данных произошла ошибка',
      );
      notifyListeners();
      Error.throwWithStackTrace(e, s);
    }
  }

  Future<void> deleteNote() async {
    try {
      final id = state.note?.id;
      if (id == null) throw NoteNullException();
      await _notesRepository.deleteNote(id);
      notifyListeners();
    } on Object catch (e, s) {
      state = NoteDetailsStateError(
        date: state.date,
        moodId: state.moodId,
        sleepId: state.sleepId,
        sleepDescription: state.sleepDescription,
        foodId: state.foodId,
        foodDescription: state.foodDescription,
        message: 'При удалении данных произошла ошибка',
      );
      notifyListeners();
      Error.throwWithStackTrace(e, s);
    }
  }
}
