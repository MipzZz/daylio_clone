import 'package:daylio_clone/src/features/sample_feature/data/repository/notes_repository.dart';
import 'package:flutter/cupertino.dart';

class NotesProvider extends ChangeNotifier {
  final NotesRepository _notesRepository;
  NotesState state = const NotesState(notes: []);

  NotesProvider({
    required NotesRepository notesRepository,
  }) : _notesRepository = notesRepository {
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

  void _readNotes(Iterable<String> notes) {
    state = state.copyWith(notes: notes.toList());
    notifyListeners();
  }
}

class NotesState {
  final List<String> notes;

  const NotesState({
    required this.notes,
  });

  NotesState copyWith({
    List<String>? notes,
  }) {
    return NotesState(
      notes: notes ?? this.notes,
    );
  }
}
