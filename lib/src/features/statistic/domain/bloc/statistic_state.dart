part of 'statistic_bloc.dart';

sealed class StatisticState {
  int get notesCount;
  double get averageMood;
  int get activityCount;
}

class StatisticState$Initial extends StatisticState {
  @override
  int get notesCount => 0;
  @override
  double get averageMood => 0;
  @override
  int get activityCount => 0;
}

class StatisticState$Data extends StatisticState {
  @override
  final int notesCount;
  @override
  final double averageMood;
  @override
  final int activityCount;

  StatisticState$Data({
    required this.notesCount,
    required this.averageMood,
    required this.activityCount,
  });
}

class StatisticState$Progress extends StatisticState {
  @override
  final int notesCount;
  @override
  final double averageMood;
  @override
  final int activityCount;

  StatisticState$Progress({
    required this.notesCount,
    required this.averageMood,
    required this.activityCount,
  });
}

class StatisticState$Error extends StatisticState {
  @override
  final int notesCount;
  @override
  final double averageMood;
  @override
  final int activityCount;
  final String message;

  StatisticState$Error({
    required this.notesCount,
    required this.averageMood,
    required this.activityCount,
    required this.message,
  });
}

