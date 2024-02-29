part of 'statistic_bloc.dart';

sealed class StatisticEvent {}

class StatisticEvent$Initialize implements StatisticEvent {}

class StatisticEvent$Update implements StatisticEvent {
  StatisticEvent$Update(this.notes);

  final Iterable<NoteModel> notes;
}

class StatisticEvent$DateRangeChange implements StatisticEvent {
  StatisticEvent$DateRangeChange(this.newDateRange);

  final DateTimeRange newDateRange;
}
class StatisticEvent$RecalculateStatistic implements StatisticEvent {}
