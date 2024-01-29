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

class AddNoteProvider{
  final NotesRepository _notesRepository;
  NoteState state =
      NoteState(note: NoteModel(id: 0, mood: '', sleep: '', food: ''));

  AddNoteProvider({
    required NotesRepository notesRepository,
  }) : _notesRepository = notesRepository;

  Future<void> saveNote({
    required String mood,
    required String sleep,
    required String food,
  }) async {
    state = state.copyWith(
        note: NoteModel(
      id: state.note.id,
      mood: mood,
      sleep: sleep,
      food: food,
    ));
    await _notesRepository.saveNote(state.note);
  }
}


