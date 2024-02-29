part of 'statistic_bloc.dart';

sealed class StatisticState {
  List<NoteModel> get notes;

  int get notesCount;

  double get averageMood;

  int get activityCount;

  Map<String, double> get moodsCount;

  DateTimeRange get dateRange;

  StatisticState copyWith({
    List<NoteModel>? notes,
    int? notesCount,
    double? averageMood,
    int? activityCount,
    Map<String, double>? moodsCount,
    DateTimeRange? dateRange,
  });
}

class StatisticState$Initial extends StatisticState {
  @override
  List<NoteModel> get notes => [];

  @override
  int get notesCount => 0;

  @override
  double get averageMood => 0;

  @override
  int get activityCount => 0;

  @override
  Map<String, double> get moodsCount => {};

  @override
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  @override
  StatisticState$Initial copyWith({
    List<NoteModel>? notes,
    int? notesCount,
    double? averageMood,
    int? activityCount,
    Map<String, double>? moodsCount,
    DateTimeRange? dateRange,
  }) =>
      StatisticState$Initial();
}

class StatisticState$Data extends StatisticState {
  StatisticState$Data({
    required this.notes,
    required this.notesCount,
    required this.averageMood,
    required this.activityCount,
    required this.moodsCount,
    required this.dateRange,
  });

  @override
  final List<NoteModel> notes;
  @override
  final int notesCount;
  @override
  final double averageMood;
  @override
  final int activityCount;
  @override
  final Map<String, double> moodsCount;
  @override
  final DateTimeRange dateRange;

  @override
  StatisticState$Data copyWith({
    List<NoteModel>? notes,
    int? notesCount,
    double? averageMood,
    int? activityCount,
    Map<String, double>? moodsCount,
    DateTimeRange? dateRange,
  }) =>
      StatisticState$Data(
        notes: notes ?? this.notes,
        notesCount: notesCount ?? this.notesCount,
        averageMood: averageMood ?? this.averageMood,
        activityCount: activityCount ?? this.activityCount,
        moodsCount: moodsCount ?? this.moodsCount,
        dateRange: dateRange ?? this.dateRange,
      );
}

class StatisticState$Progress extends StatisticState {
  StatisticState$Progress({
    required this.notes,
    required this.notesCount,
    required this.averageMood,
    required this.activityCount,
    required this.moodsCount,
    required this.dateRange,
  });

  @override
  final List<NoteModel> notes;
  @override
  final int notesCount;
  @override
  final double averageMood;
  @override
  final int activityCount;
  @override
  final Map<String, double> moodsCount;
  @override
  final DateTimeRange dateRange;

  @override
  StatisticState$Progress copyWith({
    List<NoteModel>? notes,
    int? notesCount,
    double? averageMood,
    int? activityCount,
    Map<String, double>? moodsCount,
    DateTimeRange? dateRange,
  }) => StatisticState$Progress(
      notes: notes ?? this.notes,
      notesCount: notesCount ?? this.notesCount,
      averageMood: averageMood ?? this.averageMood,
      activityCount: activityCount ?? this.activityCount,
      moodsCount: moodsCount ?? this.moodsCount,
      dateRange: dateRange ?? this.dateRange,
    );
}

class StatisticState$Error extends StatisticState {
  StatisticState$Error({
    required this.notes,
    required this.notesCount,
    required this.averageMood,
    required this.activityCount,
    required this.moodsCount,
    required this.dateRange,
    required this.message,
  });

  @override
  final List<NoteModel> notes;
  @override
  final int notesCount;
  @override
  final double averageMood;
  @override
  final int activityCount;
  @override
  final Map<String, double> moodsCount;
  @override
  final DateTimeRange dateRange;
  final String message;

  @override
  StatisticState$Error copyWith({
    List<NoteModel>? notes,
    int? notesCount,
    double? averageMood,
    int? activityCount,
    Map<String, double>? moodsCount,
    DateTimeRange? dateRange,
    String? message,
  }) => StatisticState$Error(
      notes: notes ?? this.notes,
      notesCount: notesCount ?? this.notesCount,
      averageMood: averageMood ?? this.averageMood,
      activityCount: activityCount ?? this.activityCount,
      moodsCount: moodsCount ?? this.moodsCount,
      dateRange: dateRange ?? this.dateRange,
      message: message ?? this.message,
    );
}
