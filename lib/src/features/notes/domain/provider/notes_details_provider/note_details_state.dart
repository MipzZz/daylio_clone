import 'package:daylio_clone/src/features/notes/domain/entity/food_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/mood_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/sleep_model.dart';

sealed class NoteDetailsState {
  int? get id;

  MoodModel? get mood;

  FoodModel? get food;

  SleepModel? get sleep;

  DateTime? get date;

  NoteDetailsState copyWith({
    int? id,
    MoodModel? mood,
    FoodModel? food,
    SleepModel? sleep,
    DateTime? date,
  });
}

final class NoteDetailsStateInitial implements NoteDetailsState {
  @override
  int? get id => null;

  @override
  MoodModel? get mood => null;

  @override
  FoodModel? get food => null;

  @override
  SleepModel? get sleep => null;

  @override
  DateTime? get date => null;

  @override
  NoteDetailsState copyWith(
      {int? id,
      MoodModel? mood,
      FoodModel? food,
      SleepModel? sleep,
      DateTime? date}) {
    return NoteDetailsStateInitial();
  }
}

final class NoteDetailsStateError implements NoteDetailsState {
  @override
  final int? id;
  @override
  final MoodModel? mood;
  @override
  final FoodModel? food;
  @override
  final SleepModel? sleep;
  @override
  final DateTime? date;
  final String message;

  const NoteDetailsStateError({
    required this.id,
    required this.mood,
    required this.food,
    required this.sleep,
    required this.date,
    required this.message,
  });

  @override
  NoteDetailsStateError copyWith({
    int? id,
    MoodModel? mood,
    FoodModel? food,
    SleepModel? sleep,
    DateTime? date,
    String? message,
  }) {
    return NoteDetailsStateError(
      id: id ?? this.id,
      mood: mood ?? this.mood,
      food: food ?? this.food,
      sleep: sleep ?? this.sleep,
      date: date ?? this.date,
      message: message ?? this.message,
    );
  }
}

final class NoteDetailsStateData implements NoteDetailsState {
  @override
  final int id;
  @override
  final MoodModel mood;
  @override
  final FoodModel? food;
  @override
  final SleepModel? sleep;
  @override
  final DateTime date;

  const NoteDetailsStateData({
    required this.id,
    required this.mood,
    required this.food,
    required this.sleep,
    required this.date,
  });

  @override
  NoteDetailsStateData copyWith({
    int? id,
    MoodModel? mood,
    FoodModel? food,
    SleepModel? sleep,
    DateTime? date,
  }) {
    return NoteDetailsStateData(
      id: id ?? this.id,
      mood: mood ?? this.mood,
      food: food ?? this.food,
      sleep: sleep ?? this.sleep,
      date: date ?? this.date,
    );
  }
}
