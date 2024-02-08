import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/food_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/grade_label.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/mood_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/sleep_model.dart';
import 'package:daylio_clone/src/features/notes/domain/provider/add_note_provider/add_note_state.dart';
import 'package:flutter/material.dart';

class AddNoteProvider extends ChangeNotifier {
  final NotesRepository _notesRepository;
  AddNoteState state;

  List<MoodModel> get moods => _notesRepository.getMoods();

  AddNoteProvider({
    required NotesRepository notesRepository,
  })  : _notesRepository = notesRepository,
        state = AddNoteStateNew(
          date: DateTime.now(),
          moodId: 0,
          sleepId: GradeLabel.values.first.index,
          foodId: GradeLabel.values.first.index,
          sleepDescription: '',
          foodDescription: '',
        );

  void saveDate(DateTime date) {
    state = state.copyWith(
        date: state.date
            .copyWith(day: date.day, month: date.month, year: date.year));
  }

  Future<void> saveTime(TimeOfDay time) async {
    state = state.copyWith(
        date: state.date.copyWith(hour: time.hour, minute: time.minute));
  }

  Future<void> saveMood(int id) async {
    if (id == state.moodId) return;
    state = state.copyWith(
      moodId: id,
    );
    notifyListeners();
  }

  Future<void> saveSelectedSleep(int sleepId) async {
    state = state.copyWith(
      sleepId: sleepId,
    );
  }

  Future<void> saveSleepDescription(String v) async {
    state = state.copyWith(sleepDescription: v);
  }

  Future<void> saveSelectedFood(int foodId) async {
    state = state.copyWith(foodId: foodId);
  }

  Future<void> saveFoodDescription(String v) async {
    state = state.copyWith(foodDescription: v);
  }

  Future<void> saveNote() async {
    try {
      final mood = moods[state.moodId];

      final sleepTitle = GradeLabel.values[state.sleepId].title;
      final sleepColor = GradeLabel.values[state.sleepId].color;
      final sleep = SleepModel(
          id: state.sleepId,
          title: sleepTitle,
          icon: '',
          description: state.sleepDescription,
          color: sleepColor);

      final foodTitle = GradeLabel.values[state.foodId].title;
      final foodColor = GradeLabel.values[state.foodId].color;
      final food = FoodModel(
          id: state.foodId,
          title: foodTitle,
          icon: '',
          description: state.foodDescription,
          color: foodColor);

      final note = NoteModel(
          id: null, mood: mood, sleep: sleep, food: food, date: state.date);
      await _notesRepository.saveNote(note);

      notifyListeners();
    } on Object catch (e, s) {
      state = AddNoteStateError(
        date: state.date,
        moodId: state.moodId,
        sleepId: state.sleepId,
        sleepDescription: state.sleepDescription,
        foodId: state.foodId,
        foodDescription: state.foodDescription,
        message: 'При сохранении данных произошла ошибка',
      );
      notifyListeners();
      // Error.throwWithStackTrace(e, s);
    }
  }
}
