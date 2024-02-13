import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';

sealed class NotesEvent {}

final class NotesEvent$Initialize implements NotesEvent {}

final class NotesEvent$Update implements NotesEvent {
  Iterable<NoteModel> notes;

  NotesEvent$Update(this.notes);
}
