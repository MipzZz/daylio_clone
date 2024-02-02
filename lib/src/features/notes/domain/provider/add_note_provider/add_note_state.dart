import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';

sealed class AddNoteState {
  NoteModel? get note;

  AddNoteState copyWith({NoteModel? note});
}

class AddNoteStateInitial implements AddNoteState {
  @override
  final NoteModel? note;

  AddNoteStateInitial._copy({required this.note}); // AddNoteStateInitial

  AddNoteStateInitial() : note = NoteModel.empty();

  @override
  AddNoteStateInitial copyWith({
    NoteModel? note,
  }) {
    return AddNoteStateInitial._copy(
      note: note ?? this.note,
    );
  }
}

class AddNoteStateError implements AddNoteState {
  @override
  final NoteModel? note;
  final String message;

  AddNoteStateError({required this.note, required this.message});

  @override
  AddNoteStateError copyWith({
    NoteModel? note,
    String? message,
  }) {
    return AddNoteStateError(
      note: note ?? this.note,
      message: message ?? this.message,
    );
  }
}
