import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';

sealed class NoteDetailsState {
  NoteModel? get note;

  NoteDetailsState copyWith({NoteModel? note});
}

final class NoteDetailsStateInitial implements NoteDetailsState {
  @override
  NoteModel? get note => null;

  @override
  NoteDetailsStateInitial copyWith({NoteModel? note}) =>
      NoteDetailsStateInitial();
}

final class NoteDetailsStateError implements NoteDetailsState {
  @override
  final NoteModel? note;
  final String message;

  const NoteDetailsStateError({
    required this.note,
    required this.message,
  });

  @override
  NoteDetailsStateError copyWith({
    NoteModel? note,
    String? message,
  }) {
    return NoteDetailsStateError(
      note: note ?? this.note,
      message: message ?? this.message,
    );
  }
}

final class NoteDetailsStateData implements NoteDetailsState {
  @override
  final NoteModel note;

  const NoteDetailsStateData({
    required this.note,
  });

  @override
  NoteDetailsStateData copyWith({NoteModel? note}) => NoteDetailsStateData(
        note: note ?? this.note,
      );
}
