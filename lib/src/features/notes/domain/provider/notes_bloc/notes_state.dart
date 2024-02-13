import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';

sealed class NotesState {
  List<NoteModel>? get notes;

  NotesState copyWith({
    List<NoteModel>? notes,
  });
}

final class NotesStateInitialize implements NotesState {
  @override
  List<NoteModel> get notes => [];

  @override
  NotesState copyWith({List<NoteModel>? notes}) {
    return NotesStateInitialize();
  }
}

final class NotesStateData implements NotesState {
  @override
  final List<NoteModel> notes;

  NotesStateData({required this.notes});

  @override
  NotesStateData copyWith({
    List<NoteModel>? notes,
  }) {
    return NotesStateData(
      notes: notes ?? this.notes,
    );
  }
}

final class NotesStateError implements NotesState{
  @override
  final List<NoteModel>? notes;
  final String message;

  const NotesStateError({
    required this.notes,
    required this.message,
  });

  @override
  NotesStateError copyWith({
    List<NoteModel>? notes,
    String? message,
  }) {
    return NotesStateError(
      notes: notes ?? this.notes,
      message: message ?? this.message,
    );
  }
}
