import 'package:daylio_clone/src/features/notes/domain/entity/grade_label.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';
import 'package:flutter/cupertino.dart';

sealed class AddNoteState {
  DateTime get date;

  int get moodId;

  int get sleepId;

  String get sleepDescription;

  int get foodId;

  String get foodDescription;

  AddNoteState copyWith({
    DateTime? date,
    int? moodId,
    int? sleepId,
    String? sleepDescription,
    int? foodId,
    String? foodDescription,
  });
}

@immutable
final class AddNoteState$Idle implements AddNoteState {
  const AddNoteState$Idle({
    required this.date,
    this.moodId = 0,
    this.foodId = 0,
    this.foodDescription = '',
    this.sleepId = 0,
    this.sleepDescription = '',
  });

  @override
  final DateTime date;

  @override
  final int moodId;

  @override
  final int foodId;

  @override
  final String foodDescription;

  @override
  final int sleepId;

  @override
  final String sleepDescription;

  @override
  AddNoteState$Idle copyWith({
    DateTime? date,
    int? moodId,
    int? foodId,
    String? foodDescription,
    int? sleepId,
    String? sleepDescription,
  }) =>
      AddNoteState$Idle(
        date: date ?? this.date,
        moodId: moodId ?? this.moodId,
        foodId: foodId ?? this.foodId,
        foodDescription: foodDescription ?? this.foodDescription,
        sleepId: sleepId ?? this.sleepId,
        sleepDescription: sleepDescription ?? this.sleepDescription,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddNoteState$Idle &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          moodId == other.moodId &&
          foodId == other.foodId &&
          foodDescription == other.foodDescription &&
          sleepId == other.sleepId &&
          sleepDescription == other.sleepDescription;

  @override
  int get hashCode => Object.hash(
        date,
        moodId,
        foodId,
        foodDescription,
        sleepId,
        sleepDescription,
      );
}

final class AddNoteState$Progress implements AddNoteState {
  const AddNoteState$Progress({
    required this.date,
    required this.moodId,
    required this.sleepId,
    required this.sleepDescription,
    required this.foodId,
    required this.foodDescription,
  });

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

  @override
  AddNoteState$Progress copyWith({
    DateTime? date,
    int? moodId,
    int? sleepId,
    String? sleepDescription,
    int? foodId,
    String? foodDescription,
  }) =>
      AddNoteState$Progress(
        date: date ?? this.date,
        moodId: moodId ?? this.moodId,
        sleepId: sleepId ?? this.sleepId,
        sleepDescription: sleepDescription ?? this.sleepDescription,
        foodId: foodId ?? this.foodId,
        foodDescription: foodDescription ?? this.foodDescription,
      );
}

final class AddNoteState$Created implements AddNoteState {
  @override
  DateTime get date => DateTime.now();

  @override
  String get foodDescription => '';

  @override
  int get foodId => GradeLabel.values.first.index;

  @override
  int get moodId => 0;

  @override
  String get sleepDescription => '';

  @override
  int get sleepId => 0;

  @override
  AddNoteState$Created copyWith({
    NoteModel? note,
    DateTime? date,
    int? moodId,
    int? sleepId,
    String? sleepDescription,
    int? foodId,
    String? foodDescription,
  }) =>
      AddNoteState$Created();
}

final class AddNoteState$Error implements AddNoteState {
  const AddNoteState$Error({
    required this.date,
    required this.moodId,
    required this.sleepId,
    required this.sleepDescription,
    required this.foodId,
    required this.foodDescription,
    required this.message,
  });

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

  @override
  AddNoteState$Error copyWith({
    DateTime? date,
    int? moodId,
    int? sleepId,
    String? sleepDescription,
    int? foodId,
    String? foodDescription,
    String? message,
  }) =>
      AddNoteState$Error(
        date: date ?? this.date,
        moodId: moodId ?? this.moodId,
        sleepId: sleepId ?? this.sleepId,
        sleepDescription: sleepDescription ?? this.sleepDescription,
        foodId: foodId ?? this.foodId,
        foodDescription: foodDescription ?? this.foodDescription,
        message: message ?? this.message,
      );
}
