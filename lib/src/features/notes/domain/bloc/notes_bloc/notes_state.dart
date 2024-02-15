import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';

sealed class NotesState {
  List<NoteModel> get notes;

  NotesState copyWith({
    List<NoteModel>? notes,
  });
}

final class NotesState$Initial implements NotesState {
  @override
  List<NoteModel> get notes => [];

  @override
  NotesState$Initial copyWith({
    List<NoteModel>? notes,
  }) => NotesState$Initial();
}

final class NotesState$Data implements NotesState {

  const NotesState$Data({
    required this.notes,
  });
  @override
  final List<NoteModel> notes;

  @override
  NotesState$Data copyWith({
    List<NoteModel>? notes,
  }) => NotesState$Data(
      notes: notes ?? this.notes,
    );
}

final class NotesState$Progress implements NotesState {

  const NotesState$Progress({
    required this.notes,
  });
  @override
  final List<NoteModel> notes;

  @override
  NotesState$Progress copyWith({
    List<NoteModel>? notes,
  }) => NotesState$Progress(
      notes: notes ?? this.notes,
    );
}

final class NotesState$Refreshing implements NotesState {

  const NotesState$Refreshing({
    required this.notes,
  });
  @override
  final List<NoteModel> notes;

  @override
  NotesState$Refreshing copyWith({
    List<NoteModel>? notes,
  }) => NotesState$Refreshing(
      notes: notes ?? this.notes,
    );
}

final class NotesState$Completed implements NotesState {

  const NotesState$Completed({
    required this.notes,
  });
  @override
  final List<NoteModel> notes;

  @override
  NotesState$Completed copyWith({
    List<NoteModel>? notes,
  }) => NotesState$Completed(
      notes: notes ?? this.notes,
    );
}

final class NotesState$Error implements NotesState {

  const NotesState$Error({
    required this.notes,
    required this.message,
  });
  @override
  final List<NoteModel> notes;
  final String message;

  @override
  NotesState$Error copyWith({
    List<NoteModel>? notes,
    String? message,
  }) => NotesState$Error(
      notes: notes ?? this.notes,
      message: message ?? this.message,
    );
}
