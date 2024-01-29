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

  NoteModel copyWith({
    int? id,
    String? mood,
    String? sleep,
    String? food,
  }) {
    return NoteModel(
      id: id ?? this.id,
      mood: mood ?? this.mood,
      sleep: sleep ?? this.sleep,
      food: food ?? this.food,
    );
  }
}
