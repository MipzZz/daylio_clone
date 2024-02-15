import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';

sealed class NotesEvent {}

final class NotesEvent$Initialize implements NotesEvent {}

final class NotesEvent$Update implements NotesEvent {

  NotesEvent$Update(this.notes);
  Iterable<NoteModel> notes;
}

final class NotesEvent$Refresh implements NotesEvent {
  NotesEvent$Refresh();
}
