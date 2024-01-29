import 'package:daylio_clone/src/features/notes_list/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes_list/domain/entity/note_model.dart';
import 'package:flutter/material.dart';

class NotesState {
  final List<NoteModel> notes;

  const NotesState({
    required this.notes,
  });

  NotesState copyWith({
    List<NoteModel>? notes,
  }) {
    return NotesState(
      notes: notes ?? this.notes,
    );
  }
}

class NotesProvider extends ChangeNotifier {
  final NotesRepository _notesRepository;
  NotesState state = const NotesState(notes: []);

  NotesProvider({
    required NotesRepository notesRepository,
  }) : _notesRepository = notesRepository {
    readNotes();
    _notesRepository.notesStream.listen(_readNotes);
  }

  Future<void> readNotes() async {
    try {
      final notes = await _notesRepository.readNotes();
      state = state.copyWith(notes: notes.toList());
      notifyListeners();
    } on Object {
      rethrow;
    }
  }

  Future<void> deleteNote({required int id}) async {
    try {
      await _notesRepository.deleteNote(id);
      final notes = await _notesRepository.readNotes();
      state = state.copyWith(notes: notes.toList());
      notifyListeners();
    } on Object {
      rethrow;
    }

  }

  void _readNotes(Iterable<NoteModel> notes) {
    state = state.copyWith(notes: notes.toList());
    notifyListeners();
  }
}


