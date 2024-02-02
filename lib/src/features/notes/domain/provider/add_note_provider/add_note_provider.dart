import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/food_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/grade_label.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/mood_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_state.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/sleep_model.dart';
import 'package:intl/intl.dart';


class AddNoteProvider {
  final NotesRepository _notesRepository;
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

  AddNoteProvider({
    required NotesRepository notesRepository,
  }) : _notesRepository = notesRepository {
    saveMood();
  }

  Future<void> saveMood() async {
    state = state.copyWith(
        note: state.note.copyWith(
            mood: state.moods[state.activeMoodId]));
  }


  Future<void> saveFood(FoodModel food) async {
    state = state.copyWith(
        note: state.note.copyWith(
            food: food));
  }

  Future<void> saveDate() async {
    DateFormat format = DateFormat('dd.MM.yyyy HH:mm');
    DateTime date = format.parse('$day $time');
    state = state.copyWith(note: state.note.copyWith(date: date));
  }

  Future<void> setActiveMood(int id) async {
    state = state.copyWith(activeMoodId: id);
    saveMood();
  }

  Future<void> saveNote() async {
    saveDate();
    await _notesRepository.saveNote(state.note);
  }

  Future<void> saveSleep(SleepModel sleep) async {
    state = state.copyWith(
        note: state.note.copyWith(
            sleep: sleep));
  }

  Future<void> saveSelectedSleep(GradeLabel? value) async {
    if (value != null) {
      state = state.copyWith(note: state.note.copyWith(sleep: state.note.sleep.copyWith(id: value.index)));
      state = state.copyWith(note: state.note.copyWith(sleep: state.note.sleep.copyWith(title: value.title)));
      state = state.copyWith(note: state.note.copyWith(sleep: state.note.sleep.copyWith(color: value.color)));
    }
  }

  Future<void> saveSelectedFood(GradeLabel? value) async{
    if (value != null) {
      state = state.copyWith(note: state.note.copyWith(food: state.note.food.copyWith(id: value.index)));
      state = state.copyWith(note: state.note.copyWith(food: state.note.food.copyWith(title: value.title)));
      state = state.copyWith(note: state.note.copyWith(food: state.note.food.copyWith(color: value.color)));
    }
  }

  Future<void> saveFoodDescription(String text) async {
    state = state.copyWith(note: state.note.copyWith(food: state.note.food.copyWith(description: text)));
  }

  Future<void> saveSleepDescription(String text) async {
    state = state.copyWith(note: state.note.copyWith(sleep: state.note.sleep.copyWith(description: text)));
  }
}
