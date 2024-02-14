import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';

sealed class NotesState {
  List<NoteModel>? get notes;

  NotesState copyWith({
    List<NoteModel>? notes,
  });
}

final class NotesState$Initialize implements NotesState {
  @override
  List<NoteModel> get notes => [];

  @override
  NotesState copyWith({List<NoteModel>? notes}) => NotesState$Initialize();
}

final class NotesState$Data implements NotesState {
  @override
  final List<NoteModel> notes;

  NotesState$Data({required this.notes});

  @override
  NotesState$Data copyWith({
    List<NoteModel>? notes,
  }) {
    return NotesState$Data(
      notes: notes ?? this.notes,
    );
  }
}

final class NotesState$Progress implements NotesState {
  @override
  final List<NoteModel> notes;

  NotesState$Progress({required this.notes});

  @override
  NotesState$Progress copyWith({
    List<NoteModel>? notes,
  }) {
    return NotesState$Progress(
      notes: notes ?? this.notes,
    );
  }
}

final class NotesState$Completed implements NotesState {
  @override
  final List<NoteModel> notes;

  NotesState$Completed({required this.notes});

  @override
  NotesState$Completed copyWith({
    List<NoteModel>? notes,
  }) {
    return NotesState$Completed(
      notes: notes ?? this.notes,
    );
  }
}

final class NotesState$Error implements NotesState {
  @override
  final List<NoteModel>? notes;
  final String message;

  const NotesState$Error({
    required this.notes,
    required this.message,
  });

  @override
  NotesState$Error copyWith({
    List<NoteModel>? notes,
    String? message,
  }) {
    return NotesState$Error(
      notes: notes ?? this.notes,
      message: message ?? this.message,
    );
  }
}
