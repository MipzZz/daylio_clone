import 'package:daylio_clone/src/features/notes_list/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes_list/domain/entity/note_model.dart';
import 'package:flutter/material.dart';

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
      NoteState(note: NoteModel(id: 0, mood: '', sleep: '', food: ''));

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
      notifyListeners();
    } on Object {
      rethrow;
    }
  }
}
