import 'package:daylio_clone/src/features/notes_list/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes_list/domain/entity/note_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteState {
  final NoteModel note;

  NoteState({required this.note});

  NoteState copyWith({NoteModel? note}) {
    return NoteState(note: note ?? this.note);
  }
}

class NotesDetailsProvider extends ChangeNotifier {
  final NotesRepository _notesRepository;
  final int _id;
  NoteState state =
      NoteState(note: NoteModel(id: 0, mood: '', sleep: '', food: '', date: DateTime.now()));
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
      state = state.copyWith(note: note);
      day = DateFormat('dd.MM.yyyy').format(state.note.date);
      time = DateFormat('HH:mm').format(state.note.date);
      notifyListeners();
    } on Object {
      rethrow;
    }
  }

  Future<void> updateNote() async {
    try{
      await _notesRepository.updateNote(state.note);
    } on Object {
      rethrow;
    }
  }

  Future<void> setMood(String text) async {
    state = state.copyWith(note: state.note.copyWith(mood: text));
  }

  Future<void> setDate(DateTime dateTime) async {
    day = DateFormat('dd.MM.yyyy').format(dateTime);

    DateFormat format = DateFormat('dd.MM.yyyy HH:mm');
    DateTime date = format.parse('$day $time');
    state = state.copyWith(note: state.note.copyWith(date: date));
  }

  Future<void> setTime(TimeOfDay selectedTime) async {
    // time = selectedTime.format(context); //TODO Доделать вывод даты и времени

    DateFormat format = DateFormat('dd.MM.yyyy HH:mm');
    DateTime date = format.parse('$day $time');
    state = state.copyWith(note: state.note.copyWith(date: date));
  }

}
