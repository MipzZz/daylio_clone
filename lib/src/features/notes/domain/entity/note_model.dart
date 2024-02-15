import 'package:daylio_clone/src/core/data/source/local/db/drift_storage.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/food_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/mood_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/sleep_model.dart';

class NoteModel {

  NoteModel({
    required this.id,
    required this.mood,
    required this.sleep,
    required this.food,
    required this.date,
  });

  factory NoteModel.fromNoteTableData(NoteTableData note) => NoteModel(
        id: note.id,
        mood: note.mood,
        sleep: note.sleep,
        food: note.food,
        date: note.date,
      );
  final int? id;
  final MoodModel mood;
  final SleepModel sleep;
  final FoodModel food;
  final DateTime date;



  NoteModel copyWith({
    int? id,
    MoodModel? mood,
    SleepModel? sleep,
    FoodModel? food,
    DateTime? date,
  }) => NoteModel(
      id: id ?? this.id,
      mood: mood ?? this.mood,
      sleep: sleep ?? this.sleep,
      food: food ?? this.food,
      date: date ?? this.date,
    );
}
