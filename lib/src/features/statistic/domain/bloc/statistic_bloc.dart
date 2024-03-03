import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:daylio_clone/src/core/utils/extensions/date_time_extension.dart';
import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';
import 'package:flutter/material.dart';

part 'statistic_event.dart';

part 'statistic_state.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  StatisticBloc({required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        super(StatisticState$Initial()) {
    on<StatisticEvent>(
      (event, emitter) => switch (event) {
        final StatisticEvent$Initialize event => _initStatistic(event, emitter),
        final StatisticEvent$Update event =>
          _updateNotesStatistic(event, emitter),
        final StatisticEvent$DateRangeChange event =>
          _onDateRangeChange(event, emitter),
        final StatisticEvent$RecalculateStatistic event =>
          _reCalculateStatistic(event, emitter),
      },
      transformer: sequential(),
    );
    _notesRepository.notesStream.listen(
      (notes) => add(StatisticEvent$Update(notes)),
    );
  }

  final NotesRepository _notesRepository;

  Future<void> _initStatistic(
    StatisticEvent event,
    Emitter<StatisticState> emitter,
  ) async {
    try {
      emitter(
        StatisticState$Progress(
          notes: state.notes,
          notesCount: state.notesCount,
          averageMood: state.averageMood,
          activityCount: state.activityCount,
          moodsCount: state.moodsCount,
          dateRange: state.dateRange,
        ),
      );

      final notes = await _notesRepository.readNotes();
      final averageMood = _calculateAverageMood(notes);
      final activityCount = _activityCount(notes);
      final moodsCount = _moodsCount(notes);
      final dateRange = _calculateInitDateRange(notes);

      emitter(
        StatisticState$Data(
          notes: notes.toList(),
          notesCount: notes.length,
          averageMood: averageMood,
          activityCount: activityCount,
          moodsCount: moodsCount,
          dateRange: dateRange,
        ),
      );
    } on Object {
      emitter(
        StatisticState$Error(
          notes: state.notes,
          notesCount: state.notesCount,
          averageMood: state.averageMood,
          activityCount: state.activityCount,
          moodsCount: state.moodsCount,
          dateRange: state.dateRange,
          message: 'При обновлении статистики произошла ошибка',
        ),
      );
      rethrow;
    }
  }

  DateTimeRange _calculateInitDateRange(Iterable<NoteModel> notes) {
    final sortedNotes = notes.sorted((a, b) => a.date.compareTo(b.date));
    return DateTimeRange(start: sortedNotes.first.date, end: sortedNotes.last.date);
  }


  void _updateNotesStatistic(
    StatisticEvent$Update event,
    Emitter<StatisticState> emitter,
  ) {
    emitter(state.copyWith(notes: event.notes.toList()));
    add(StatisticEvent$RecalculateStatistic());
  }

  void _onDateRangeChange(
    StatisticEvent$DateRangeChange event,
    Emitter<StatisticState> emitter,
  ) {
    emitter(state.copyWith(dateRange: event.newDateRange));
    add(StatisticEvent$RecalculateStatistic());
  }

  void _reCalculateStatistic(
    StatisticEvent$RecalculateStatistic event,
    Emitter<StatisticState> emitter,
  ) {
    final startDate = state.dateRange.start.withoutTime();
    final endDate = state.dateRange.end.endOfDay();
    final notesInRange = state.notes.where(
      (note) =>
          (note.date.isAfter(startDate) ||
              note.date.isAtSameMomentAs(startDate)) &&
          (note.date.isAtSameMomentAs(endDate) || note.date.isBefore(endDate)),
    );
    final averageMood = _calculateAverageMood(notesInRange);
    final activityCount = _activityCount(notesInRange);
    final moodsCount = _moodsCount(notesInRange);
    emitter(
      StatisticState$Data(
        notes: state.notes,
        notesCount: notesInRange.length,
        averageMood: averageMood,
        activityCount: activityCount,
        moodsCount: moodsCount,
        dateRange: state.dateRange,
      ),
    );
  }

  Map<String, double> _moodsCount(Iterable<NoteModel> notes) {
    final moodMap = <String, double>{};
    for (final note in notes) {
      moodMap[note.mood.title] = (moodMap[note.mood.title] ?? 0) + 1;
    }
    return moodMap;
  }

  double _calculateAverageMood(Iterable<NoteModel> notes) {
    if (notes.isEmpty) return 0.0;
    final moodIdList = notes.map((e) => e.mood.id);
    final averageMood =
        (moodIdList.reduce((value, element) => value + element)) / notes.length;
    return 5 - averageMood;
  }

  int _activityCount(Iterable<NoteModel> notes) {
    if (notes.isEmpty) return 0;
    return notes.length * 2;
  }
}
