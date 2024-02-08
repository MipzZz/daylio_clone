import 'package:daylio_clone/src/features/notes/domain/entity/food_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/grade_label.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/mood_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/sleep_model.dart';

sealed class NoteDetailsState {
  NoteModel? get note;
  DateTime get date;
  int get moodId;
  int get sleepId;
  String get sleepDescription;
  int get foodId;
  String get foodDescription;

  NoteDetailsState copyWith({
    DateTime? date,
    int? moodId,
    int? sleepId,
    String? sleepDescription,
    int? foodId,
    String? foodDescription,
  });
}

final class NoteDetailsStateInitial implements NoteDetailsState {
  @override
  DateTime get date => DateTime.now();

  @override
  String get foodDescription => '';

  @override
  int get foodId => GradeLabel.values.first.index;

  @override
  // TODO(fix): ref to enum
  int get moodId => 0;

  @override
  NoteModel? get note => null;

  @override
  String get sleepDescription => throw UnimplementedError();

  @override
  // TODO: implement sleepId
  int get sleepId => throw UnimplementedError();

  @override
  NoteDetailsStateInitial copyWith({
    DateTime? date,
    String? foodDescription,
    int? foodId,
    int? moodId,
    String? sleepDescription,
    int? sleepId,
  }) {
    return NoteDetailsStateInitial();
  }
}

final class NoteDetailsStateData implements NoteDetailsState {
  @override
  final NoteModel note;
  @override
  final DateTime date;
  @override
  final int moodId;
  @override
  final int sleepId;
  @override
  final String sleepDescription;
  @override
  final int foodId;
  @override
  final String foodDescription;

  const NoteDetailsStateData({
    required this.note,
    required this.date,
    required this.moodId,
    required this.sleepId,
    required this.sleepDescription,
    required this.foodId,
    required this.foodDescription,
  });

  @override
  NoteDetailsStateData copyWith({
    NoteModel? note,
    DateTime? date,
    int? moodId,
    int? sleepId,
    String? sleepDescription,
    int? foodId,
    String? foodDescription,
  }) {
    return NoteDetailsStateData(
      note: note ?? this.note,
      date: date ?? this.date,
      moodId: moodId ?? this.moodId,
      sleepId: sleepId ?? this.sleepId,
      sleepDescription: sleepDescription ?? this.sleepDescription,
      foodId: foodId ?? this.foodId,
      foodDescription: foodDescription ?? this.foodDescription,
    );
  }
}

final class NoteDetailsStateError implements NoteDetailsState {
  @override
  final NoteModel? note;
  @override
  final DateTime date;
  @override
  final int moodId;
  @override
  final int sleepId;
  @override
  final String sleepDescription;
  @override
  final int foodId;
  @override
  final String foodDescription;
  final String message;
  const NoteDetailsStateError({
    this.note,
    required this.date,
    required this.moodId,
    required this.sleepId,
    required this.sleepDescription,
    required this.foodId,
    required this.foodDescription,
    required this.message,
  });

  @override
  NoteDetailsStateError copyWith({
    NoteModel? note,
    DateTime? date,
    int? moodId,
    int? sleepId,
    String? sleepDescription,
    int? foodId,
    String? foodDescription,
    String? message,
  }) {
    return NoteDetailsStateError(
      note: note ?? this.note,
      date: date ?? this.date,
      moodId: moodId ?? this.moodId,
      sleepId: sleepId ?? this.sleepId,
      sleepDescription: sleepDescription ?? this.sleepDescription,
      foodId: foodId ?? this.foodId,
      foodDescription: foodDescription ?? this.foodDescription,
      message: message ?? this.message,
    );
  }
}
