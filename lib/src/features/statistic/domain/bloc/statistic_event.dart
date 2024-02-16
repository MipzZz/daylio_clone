part of 'statistic_bloc.dart';

sealed class StatisticEvent {}

class StatisticEvent$Initialize extends StatisticEvent {}

class StatisticEvent$Update extends StatisticEvent {
  StatisticEvent$Update(this.notes);

  final Iterable<NoteModel> notes;
}
