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
        message: 'Something went wrong',
      );
      notifyListeners();
      Error.throwWithStackTrace(e, s);
    }
  }

  // Future<void> readNote() async {
  //   try {
  //     final note = await _notesRepository.readNote(_id);
  //     // throw Exception('Some error');
  //     state = state.copyWith(note: note, activeMoodId: note.mood.id);
  //     day = DateFormat('dd.MM.yyyy').format(state.note.date);
  //     time = DateFormat('HH:mm').format(state.note.date);
  //     notifyListeners();
  //   } on Object {
  //     rethrow;
  //   }
  // }

  Future<void> updateNote() async {
    try {
      final note = state.note;
      if (note != null && note.id != null) {
        await _notesRepository.updateNote(note);
      }
    } on Object {
      rethrow;
    }
  }

  Future<void> deleteNote({required int id}) async {
    try {
      await _notesRepository.deleteNote(id);
      notifyListeners();
    } on Object {
      rethrow;
    }
  }

  void updateDate(DateTime date) {
    final updatedNote = state.note;
    if (updatedNote == null) return;
    updatedNote.copyWith(
        date: updatedNote.date
            .copyWith(day: date.day, month: date.month, year: date.year));
    state = state.copyWith(note: updatedNote);
    notifyListeners();
  }

  void updateTime(TimeOfDay time) {
    final updatedNote = state.note;
    if (updatedNote == null) return;
    updatedNote.copyWith(
      date: updatedNote.date.copyWith(hour: time.hour, minute: time.minute),
    );
    state = state.copyWith(note: updatedNote);
    notifyListeners();
  }

  // Future<void> setDate(DateTime dateTime) async {
  //   day = dateTime.dmyyyy();
  //   updateDate();
  // }

  // Future<void> setTime(TimeOfDay selectedTime) async {
  //   time = '${selectedTime.hour}:${selectedTime.minute}';
  //   updateDate();
  // }

  // Future<void> updateDate() async {
  //   DateFormat format = DateFormat('dd.MM.yyyy HH:mm');
  //   DateTime date = format.parse('$day $time');
  //   state = state.copyWith(
  //     note: state.note?.copyWith(date: date),
  //   );
  // }

  Future<void> updateFoodDescription(String text) async {
    state = state.copyWith(
      note: state.note?.copyWith(
        food: state.note?.food.copyWith(description: text),
      ),
    );
  }

  Future<void> updateSleepDescription(String text) async {
    state = state.copyWith(
      note: state.note?.copyWith(
        sleep: state.note?.sleep.copyWith(description: text),
      ),
    );
  }

  Future<void> updateSleepGrade(GradeLabel? value) async {
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

  Future<void> updateFoodGrade(GradeLabel? value) async {
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

  Future<void> setActiveMood(int id) async {
    state = state.copyWith(
      note: state.note?.copyWith(
        mood: moods[id],
      ),
    );
  }
}
