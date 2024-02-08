sealed class StatisticState {
  int? get notesCount;

  double? get averageMood;

  int? get activityCount;

  StatisticState copyWith({int? notesCount, double? averageMood, int? activityCount});
}

final class StatisticStateInitial implements StatisticState {
  @override
  int? get notesCount => null;

  @override
  double? get averageMood => null;

  @override
  int? get activityCount => null;

  @override
  StatisticStateInitial copyWith(
          {int? notesCount, double? averageMood, int? activityCount}) =>
      StatisticStateInitial();
}

final class StatisticStateData implements StatisticState {
  @override
  final int notesCount;
  @override
  final double averageMood;
  @override
  final int activityCount;

  const StatisticStateData(
      {required this.notesCount,
      required this.averageMood,
      required this.activityCount});

  @override
  StatisticStateData copyWith(
      {int? notesCount, double? averageMood, int? activityCount}) {
    return StatisticStateData(
        notesCount: notesCount ?? this.notesCount,
        averageMood: averageMood ?? this.averageMood,
        activityCount: activityCount ?? this.activityCount);
  }
}

final class StatisticStateError implements StatisticState {
  @override
  final int? notesCount;
  @override
  final double? averageMood;
  @override
  final int? activityCount;
  final String message;

  const StatisticStateError({
    required this.notesCount,
    required this.averageMood,
    required this.activityCount,
    required this.message,
  });

  @override
  StatisticStateError copyWith({
    int? notesCount,
    double? averageMood,
    int? activityCount,
    String? message,
  }) {
    return StatisticStateError(
      notesCount: notesCount ?? this.notesCount,
      averageMood: averageMood ?? this.averageMood,
      activityCount: activityCount ?? this.activityCount,
      message: message ?? this.message,
    );
  }
}
