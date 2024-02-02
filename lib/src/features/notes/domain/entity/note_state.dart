import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';

class NoteState {
  final NoteModel note;

  final int activeMoodId;

  NoteState({required this.note, required this.activeMoodId});

  NoteState copyWith({
    NoteModel? note,
    int? activeMoodId,
  }) {
    return NoteState(
      note: note ?? this.note,
      activeMoodId: activeMoodId ?? this.activeMoodId,
    );
  }
}