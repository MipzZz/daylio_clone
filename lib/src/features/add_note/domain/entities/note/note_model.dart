import '../mood/mood_model.dart';
import '../sleep/sleep_model.dart';
import '../food/food_model.dart';

class NoteModel {
  final int id;
  final MoodModel sood;
  final SleepModel sleep;
  final FoodModel food;

  NoteModel({required this.id, required this.sood, required this.sleep, required this.food});
}