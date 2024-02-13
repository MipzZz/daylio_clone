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

final class AddNoteState$Idle implements AddNoteState {
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

  const AddNoteState$Idle({
    required this.date,
    this.moodId = 0,
    this.foodId = 0,
    this.foodDescription = '',
    this.sleepId = 0,
    this.sleepDescription = '',
  });

  @override
  AddNoteState$Idle copyWith({
    DateTime? date,
    int? moodId,
    int? foodId,
    String? foodDescription,
    int? sleepId,
    String? sleepDescription,
  }) {
    return AddNoteState$Idle(
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

final class AddNoteState$Progress implements AddNoteState{
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

  const AddNoteState$Progress({
    required this.date,
    required this.moodId,
    required this.sleepId,
    required this.sleepDescription,
    required this.foodId,
    required this.foodDescription,
  });

  @override
  AddNoteState$Progress copyWith({
    DateTime? date,
    int? moodId,
    int? sleepId,
    String? sleepDescription,
    int? foodId,
    String? foodDescription,
  }) {
    return AddNoteState$Progress(
      date: date ?? this.date,
      moodId: moodId ?? this.moodId,
      sleepId: sleepId ?? this.sleepId,
      sleepDescription: sleepDescription ?? this.sleepDescription,
      foodId: foodId ?? this.foodId,
      foodDescription: foodDescription ?? this.foodDescription,
    );
  }
}

final class AddNoteState$Created implements AddNoteState{
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


  const AddNoteState$Created({
    required this.date,
    required this.moodId,
    required this.sleepId,
    required this.sleepDescription,
    required this.foodId,
    required this.foodDescription,
  });

  @override
  AddNoteState$Created copyWith({
    DateTime? date,
    int? moodId,
    int? sleepId,
    String? sleepDescription,
    int? foodId,
    String? foodDescription,
  }) {
    return AddNoteState$Created(
      date: date ?? this.date,
      moodId: moodId ?? this.moodId,
      sleepId: sleepId ?? this.sleepId,
      sleepDescription: sleepDescription ?? this.sleepDescription,
      foodId: foodId ?? this.foodId,
      foodDescription: foodDescription ?? this.foodDescription,
    );
  }
}

final class AddNoteState$Error implements AddNoteState {
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
  AddNoteState$Error copyWith({
    DateTime? date,
    int? moodId,
    int? sleepId,
    String? sleepDescription,
    int? foodId,
    String? foodDescription,
    String? message,
  }) {
    return AddNoteState$Error(
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
