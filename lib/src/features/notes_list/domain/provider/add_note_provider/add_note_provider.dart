import 'package:daylio_clone/src/features/notes_list/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes_list/domain/entity/note_model.dart';

class NoteState {
  final NoteModel note;

  NoteState({required this.note});

  NoteState copyWith({NoteModel? note}) {
    return NoteState(note: note ?? this.note);
  }
}

class AddNoteProvider {
  final NotesRepository _notesRepository;
  NoteState state =
      NoteState(note: NoteModel(id: 0, mood: '', sleep: '', food: ''));

  AddNoteProvider({
    required NotesRepository notesRepository,
  }) : _notesRepository = notesRepository;

  Future<void> saveMood(String mood) async {
    state = state.copyWith(note: state.note.copyWith(mood: mood));
  }

  Future<void> saveSleep(String sleep) async {
    state = state.copyWith(note: state.note.copyWith(sleep: sleep));
  }

  Future<void> saveFood(String food) async {
    state = state.copyWith(note: state.note.copyWith(food: food));
  }

  Future<void> saveNote() async {
    await _notesRepository.saveNote(state.note);
  }
}
