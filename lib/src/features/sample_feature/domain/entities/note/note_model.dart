import 'package:daylio_clone/src/features/sample_feature/domain/entities/food/food_model.dart';
import 'package:daylio_clone/src/features/sample_feature/domain/entities/mood/mood_model.dart';
import 'package:daylio_clone/src/features/sample_feature/domain/entities/sleep/sleep_model.dart';

class NoteModel {
  final int id;
  final MoodModel sood;
  final SleepModel sleep;
  final FoodModel food;

  NoteModel({required this.id, required this.sood, required this.sleep, required this.food});
}