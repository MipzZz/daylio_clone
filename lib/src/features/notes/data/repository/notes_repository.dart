import 'dart:async';

import 'package:daylio_clone/src/core/data/source/local/db/drift_storage.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';
import 'package:drift/drift.dart';

class NotesRepository {
  final AppDb _driftStorage;
  late final StreamController<Iterable<NoteModel>> _notesController;

  Stream<Iterable<NoteModel>> get notesStream => _notesController.stream;

  NotesRepository({required AppDb database})
      : _notesController = StreamController.broadcast(),
        _driftStorage = database {
    _init();
  }

  Future<void> _init() async {
    final updateNotes = await _driftStorage.readNotes();
    // await Future.delayed(const Duration(seconds: 3));
    final notes = updateNotes.map(NoteModel.fromNoteTableData);
    _notesController.add(notes);
  }

  Future<void> saveNote(NoteModel note) async {
    try {
      final noteCompanion = NoteTableCompanion(
        mood: Value(note.mood),
        sleep: Value(note.sleep),
        food: Value(note.food),
        date: Value(note.date),
      );
      await _driftStorage.saveNote(noteCompanion);
      await Future.delayed(const Duration(seconds: 5));
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

  Future<void> updateNote(NoteModel note) async {
    try {
      final id = note.id;
      if (id != null) {
        final noteCompanion = NoteTableCompanion(
          id: Value(id),
          mood: Value(note.mood),
          sleep: Value(note.sleep),
          food: Value(note.food),
          date: Value(note.date),
        );
        await _driftStorage.updateNote(noteCompanion);
        final updateNotes = await _driftStorage.readNotes();
        final notes = updateNotes.map(NoteModel.fromNoteTableData);
        _notesController.add(notes);
      }
    } on Object {
      rethrow;
    }
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
