import 'package:daylio_clone/src/features/notes/domain/entity/grade_label.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';
import 'package:flutter/material.dart';


sealed class AddNoteState {
  DateTime get date;

  int get moodId;

  int get sleepId;

  String get sleepDescription;

  int get foodId;

  String get foodDescription;

  bool? get inTwoHoursPeriod;

  AddNoteState copyWith({
    DateTime? date,
    int? moodId,
    int? sleepId,
    String? sleepDescription,
    int? foodId,
    String? foodDescription,
    bool? inTwoHoursPeriod,
  });
}

final class AddNoteState$Initial implements AddNoteState {
  AddNoteState$Initial({
    required this.date,
    this.moodId = 0,
    this.foodId = 0,
    this.foodDescription = '',
    this.sleepId = 0,
    this.sleepDescription = '',
    this.inTwoHoursPeriod,
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
  final bool? inTwoHoursPeriod;

  @override
  AddNoteState$Initial copyWith({
    DateTime? date,
    int? moodId,
    int? foodId,
    String? foodDescription,
    int? sleepId,
    String? sleepDescription,
    bool? inTwoHoursPeriod,
  }) => AddNoteState$Initial(
      date: date ?? this.date,
      moodId: moodId ?? this.moodId,
      foodId: foodId ?? this.foodId,
      foodDescription: foodDescription ?? this.foodDescription,
      sleepId: sleepId ?? this.sleepId,
      sleepDescription: sleepDescription ?? this.sleepDescription,
      inTwoHoursPeriod: inTwoHoursPeriod ?? this.inTwoHoursPeriod,
    );
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
    this.inTwoHoursPeriod,
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
  final bool? inTwoHoursPeriod;

  @override
  AddNoteState$Idle copyWith({
    DateTime? date,
    int? moodId,
    int? foodId,
    String? foodDescription,
    int? sleepId,
    String? sleepDescription,
    bool? inTwoHoursPeriod,
  }) =>
      AddNoteState$Idle(
        date: date ?? this.date,
        moodId: moodId ?? this.moodId,
        foodId: foodId ?? this.foodId,
        foodDescription: foodDescription ?? this.foodDescription,
        sleepId: sleepId ?? this.sleepId,
        sleepDescription: sleepDescription ?? this.sleepDescription,
        inTwoHoursPeriod: inTwoHoursPeriod ?? this.inTwoHoursPeriod,
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
          sleepDescription == other.sleepDescription &&
          sleepDescription == other.sleepDescription;

  @override
  int get hashCode => Object.hash(
        date,
        moodId,
        foodId,
        foodDescription,
        sleepId,
        sleepDescription,
        inTwoHoursPeriod,
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
    required this.inTwoHoursPeriod,
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
  final bool? inTwoHoursPeriod;

  @override
  AddNoteState$Progress copyWith({
    DateTime? date,
    int? moodId,
    int? sleepId,
    String? sleepDescription,
    int? foodId,
    String? foodDescription,
    bool? inTwoHoursPeriod,
  }) =>
      AddNoteState$Progress(
        date: date ?? this.date,
        moodId: moodId ?? this.moodId,
        sleepId: sleepId ?? this.sleepId,
        sleepDescription: sleepDescription ?? this.sleepDescription,
        foodId: foodId ?? this.foodId,
        foodDescription: foodDescription ?? this.foodDescription,
        inTwoHoursPeriod: inTwoHoursPeriod ?? this.inTwoHoursPeriod,
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
  bool? get inTwoHoursPeriod => null;

  @override
  AddNoteState$Created copyWith({
    NoteModel? note,
    DateTime? date,
    int? moodId,
    int? sleepId,
    String? sleepDescription,
    int? foodId,
    String? foodDescription,
    bool? inTwoHoursPeriod,
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
    required this.inTwoHoursPeriod,
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
  @override
  final bool? inTwoHoursPeriod;
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
    bool? inTwoHoursPeriod,
  }) =>
      AddNoteState$Error(
        date: date ?? this.date,
        moodId: moodId ?? this.moodId,
        sleepId: sleepId ?? this.sleepId,
        sleepDescription: sleepDescription ?? this.sleepDescription,
        foodId: foodId ?? this.foodId,
        foodDescription: foodDescription ?? this.foodDescription,
        inTwoHoursPeriod: inTwoHoursPeriod ?? this.inTwoHoursPeriod,
        message: message ?? this.message,
      );
}
