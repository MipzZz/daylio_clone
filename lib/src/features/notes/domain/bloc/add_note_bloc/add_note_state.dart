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

final class AddNoteStateNew implements AddNoteState {
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

  const AddNoteStateNew({
    required this.date,
    this.moodId = 0,
    this.foodId = 0,
    this.foodDescription = '',
    this.sleepId = 0,
    this.sleepDescription = '',
  });

  @override
  AddNoteStateNew copyWith({
    DateTime? date,
    int? moodId,
    int? foodId,
    String? foodDescription,
    int? sleepId,
    String? sleepDescription,
  }) {
    return AddNoteStateNew(
      date: date ?? this.date,
      moodId: moodId ?? this.moodId,
      foodId: foodId ?? this.foodId,
      foodDescription: foodDescription ?? this.foodDescription,
      sleepId: sleepId ?? this.sleepId,
      sleepDescription: sleepDescription ?? this.sleepDescription,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddNoteStateNew &&
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

final class AddNoteStateError implements AddNoteState {
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

  const AddNoteStateError({
    required this.date,
    required this.moodId,
    required this.sleepId,
    required this.sleepDescription,
    required this.foodId,
    required this.foodDescription,
    required this.message,
  });

  @override
  AddNoteStateError copyWith({
    DateTime? date,
    int? moodId,
    int? sleepId,
    String? sleepDescription,
    int? foodId,
    String? foodDescription,
    String? message,
  }) {
    return AddNoteStateError(
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

sealed class AddNoteState$Another {}

final class AddNoteState$Idle implements AddNoteState$Another {}

final class AddNoteState$Progress implements AddNoteState$Another {}

final class AddNoteState$Created implements AddNoteState$Another {}

final class AddNoteState$Failure implements AddNoteState$Another {
  final String message;

  const AddNoteState$Failure({
    required this.message,
  });
}
