import 'package:daylio_clone/src/core/data/source/local/db/drift_storage.dart';

class NoteModel {
  final int id;
  final String mood;
  final String sleep;
  final String food;

  NoteModel({
    required this.id,
    required this.mood,
    required this.sleep,
    required this.food,
  });

  factory NoteModel.fromNoteTableData(NoteTableData note) => NoteModel(
        id: note.id,
        mood: note.mood,
        sleep: note.sleep,
        food: note.food,
      );
}
