import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';

sealed class NotesState {
  List<NoteModel> get notes;

  copyWith({
    List<NoteModel>? notes,
  });
}

final class NotesState$Initial implements NotesState {
  @override
  List<NoteModel> get notes => [];

  @override
  copyWith({
    List<NoteModel>? notes,
  }) => NotesState$Initial();
}

final class NotesState$Data implements NotesState {
  @override
  final List<NoteModel> notes;

  const NotesState$Data({
    required this.notes,
  });

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

  const NotesState$Progress({
    required this.notes,
  });

  @override
  NotesState$Progress copyWith({
    List<NoteModel>? notes,
  }) {
    return NotesState$Progress(
      notes: notes ?? this.notes,
    );
  }
}

final class NotesState$Refreshing implements NotesState {
  @override
  final List<NoteModel> notes;

  const NotesState$Refreshing({
    required this.notes,
  });

  @override
  NotesState$Refreshing copyWith({
    List<NoteModel>? notes,
  }) {
    return NotesState$Refreshing(
      notes: notes ?? this.notes,
    );
  }
}

final class NotesState$Completed implements NotesState {
  @override
  final List<NoteModel> notes;

  const NotesState$Completed({
    required this.notes,
  });

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
  final List<NoteModel> notes;
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
