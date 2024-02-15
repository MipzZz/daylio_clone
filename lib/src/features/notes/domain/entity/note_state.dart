import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';

class NoteState {

  NoteState({required this.note, required this.activeMoodId});
  final NoteModel note;

  final int activeMoodId;

  NoteState copyWith({
    NoteModel? note,
    int? activeMoodId,
  }) => NoteState(
      note: note ?? this.note,
      activeMoodId: activeMoodId ?? this.activeMoodId,
    );
}
