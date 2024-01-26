import 'dart:async';

class NotesRepository {
  final DriftDB _driftStorage;
  late final StreamController<Iterable<String>> _notesController;

  Stream<Iterable<String>> get notesStream => _notesController.stream;

  NotesRepository({
    required DriftDB driftStorage,
  })  : _driftStorage = driftStorage,
        _notesController = StreamController.broadcast();

  /// from ur changeNotifier
  Future<void> saveNote(String note) async {
    try {
      await _driftStorage.saveNote(note);
      final updateNotes = await _driftStorage.readNotes();

      _notesController.add(updateNotes);
    } on Object {
      rethrow;
    }
  }

  Future<Iterable<String>> readNotes() async {
    return await _driftStorage.readNotes();
  }
}

abstract interface class DriftDB {
  Future<void> saveNote(String note);
  Future<List<String>> readNotes();
}
