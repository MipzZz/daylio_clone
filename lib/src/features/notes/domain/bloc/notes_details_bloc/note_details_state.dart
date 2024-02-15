import 'package:daylio_clone/src/features/notes/domain/entity/grade_label.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';

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

final class NoteDetailsState$Initial implements NoteDetailsState {
  @override
  DateTime get date => DateTime.now();

  @override
  String get foodDescription => '';

  @override
  int get foodId => GradeLabel.values.first.index;

  @override
  int get moodId => 0;

  @override
  NoteModel? get note => null;

  @override
  String get sleepDescription => '';

  @override
  int get sleepId => 0;

  @override
  NoteDetailsState$Initial copyWith({
    DateTime? date,
    String? foodDescription,
    int? foodId,
    int? moodId,
    String? sleepDescription,
    int? sleepId,
  }) => NoteDetailsState$Initial();
}

final class NoteDetailsState$Progress implements NoteDetailsState {

  const NoteDetailsState$Progress({
    required this.note,
    required this.date,
    required this.moodId,
    required this.sleepId,
    required this.sleepDescription,
    required this.foodId,
    required this.foodDescription,
  });
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

  @override
  NoteDetailsState$Progress copyWith({
    NoteModel? note,
    DateTime? date,
    int? moodId,
    int? sleepId,
    String? sleepDescription,
    int? foodId,
    String? foodDescription,
  }) => NoteDetailsState$Progress(
      note: note ?? this.note,
      date: date ?? this.date,
      moodId: moodId ?? this.moodId,
      sleepId: sleepId ?? this.sleepId,
      sleepDescription: sleepDescription ?? this.sleepDescription,
      foodId: foodId ?? this.foodId,
      foodDescription: foodDescription ?? this.foodDescription,
    );
}

final class NoteDetailsState$Data implements NoteDetailsState {

  const NoteDetailsState$Data({
    required this.note,
    required this.date,
    required this.moodId,
    required this.sleepId,
    required this.sleepDescription,
    required this.foodId,
    required this.foodDescription,
  });
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

  @override
  NoteDetailsState$Data copyWith({
    NoteModel? note,
    DateTime? date,
    int? moodId,
    int? sleepId,
    String? sleepDescription,
    int? foodId,
    String? foodDescription,
  }) => NoteDetailsState$Data(
      note: note ?? this.note,
      date: date ?? this.date,
      moodId: moodId ?? this.moodId,
      sleepId: sleepId ?? this.sleepId,
      sleepDescription: sleepDescription ?? this.sleepDescription,
      foodId: foodId ?? this.foodId,
      foodDescription: foodDescription ?? this.foodDescription,
    );
}

final class NoteDetailsState$Completed implements NoteDetailsState {

  const NoteDetailsState$Completed({
    required this.note,
    required this.date,
    required this.moodId,
    required this.sleepId,
    required this.sleepDescription,
    required this.foodId,
    required this.foodDescription,
  });
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

  @override
  NoteDetailsState$Completed copyWith({
    NoteModel? note,
    DateTime? date,
    int? moodId,
    int? sleepId,
    String? sleepDescription,
    int? foodId,
    String? foodDescription,
  }) => NoteDetailsState$Completed(
      note: note ?? this.note,
      date: date ?? this.date,
      moodId: moodId ?? this.moodId,
      sleepId: sleepId ?? this.sleepId,
      sleepDescription: sleepDescription ?? this.sleepDescription,
      foodId: foodId ?? this.foodId,
      foodDescription: foodDescription ?? this.foodDescription,
    );
}

final class NoteDetailsState$Error implements NoteDetailsState {
  const NoteDetailsState$Error({
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

  @override
  NoteDetailsState$Error copyWith({
    NoteModel? note,
    DateTime? date,
    int? moodId,
    int? sleepId,
    String? sleepDescription,
    int? foodId,
    String? foodDescription,
    String? message,
  }) => NoteDetailsState$Error(
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
