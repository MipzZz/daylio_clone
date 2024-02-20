part of 'statistic_bloc.dart';

sealed class StatisticState {
  int get notesCount;

  double get averageMood;

  int get activityCount;

Map<String, double> get moodsCount;
}

class StatisticState$Initial extends StatisticState {
  @override
  int get notesCount => 0;

  @override
  double get averageMood => 0;

  @override
  int get activityCount => 0;

  @override
  Map<String, double> get moodsCount => {};
}

class StatisticState$Data extends StatisticState {
  StatisticState$Data({
    required this.notesCount,
    required this.averageMood,
    required this.activityCount,
    required this.moodsCount,
  });

  @override
  final int notesCount;
  @override
  final double averageMood;
  @override
  final int activityCount;
  @override
  final Map<String, double> moodsCount;
}

class StatisticState$Progress extends StatisticState {
  StatisticState$Progress({
    required this.notesCount,
    required this.averageMood,
    required this.activityCount,
    required this.moodsCount,
  });

  @override
  final int notesCount;
  @override
  final double averageMood;
  @override
  final int activityCount;
  @override
final Map<String, double> moodsCount;
}

class StatisticState$Error extends StatisticState {
  StatisticState$Error({
    required this.notesCount,
    required this.averageMood,
    required this.activityCount,
    required this.moodsCount,
    required this.message,
  });

  @override
  final int notesCount;
  @override
  final double averageMood;
  @override
  final int activityCount;
  @override
  final Map<String, double> moodsCount;
  final String message;
}
