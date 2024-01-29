import 'dart:async';

import 'package:daylio_clone/src/core/data/source/local/db/drift_storage.dart';
import 'package:daylio_clone/src/features/notes_list/domain/entity/note_model.dart';
import 'package:drift/drift.dart';

class NotesRepository {
  final _driftStorage = AppDb();
  late final StreamController<Iterable<NoteModel>> _notesController;

  Stream<Iterable<NoteModel>> get notesStream => _notesController.stream;

  NotesRepository() : _notesController = StreamController.broadcast();

  Future<void> saveNote(NoteModel note) async {
    try {
      final noteCompanion = NoteTableCompanion(
        mood: Value(note.mood),
        sleep: Value(note.sleep),
        food: Value(note.food),
      );
      await _driftStorage.saveNote(noteCompanion);
      final updateNotes = await _driftStorage.readNotes();
      final notes = updateNotes.map(NoteModel.fromNoteTableData);
      _notesController.add(notes);
    } on Object {
      rethrow;
    }
  }

  Future<Iterable<NoteModel>> readNotes() async {
    final updateNotes = await _driftStorage.readNotes();
    final notes = updateNotes.map(NoteModel.fromNoteTableData);
    return notes;
  }

  Future<NoteModel> readNote(int id) async {
    final updateNote = await _driftStorage.readNote(id);
    final note = NoteModel.fromNoteTableData(updateNote);
    return note;
  }

  Future<void> deleteNote(int id) async {
    try {
      await _driftStorage.deleteNote(id);
      final updateNotes = await _driftStorage.readNotes();
      final notes = updateNotes.map(NoteModel.fromNoteTableData);
      _notesController.add(notes);
    } on Object {
      rethrow;
    }
  }
}
