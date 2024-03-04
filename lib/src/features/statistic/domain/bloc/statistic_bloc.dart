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

      emitter(
        StatisticState$Data(
          notes: notes.toList(),
          notesCount: notes.length,
          averageMood: _calculateAverageMood(notes),
          activityCount: _countActivity(notes),
          moodsCount: _countMoods(notes),
          dateRange: _calculateInitDateRange(notes),
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
    if (notes.isEmpty) {
      return DateTimeRange(start: DateTime.now(), end: DateTime.now());
    }
    final sortedNotes = notes.sorted((a, b) => a.date.compareTo(b.date));
    return DateTimeRange(
      start: sortedNotes.first.date,
      end: sortedNotes.last.date,
    );
  }

  void _updateNotesStatistic(
    StatisticEvent$Update event,
    Emitter<StatisticState> emitter,
  ) {
    emitter(
      StatisticState$Data(
        notes: event.notes.toList(),
        notesCount: event.notes.length,
        averageMood: _calculateAverageMood(event.notes),
        activityCount: _countActivity(event.notes),
        moodsCount: _countMoods(event.notes),
        dateRange: state.dateRange,
      ),
    );
  }

  void _onDateRangeChange(
    StatisticEvent$DateRangeChange event,
    Emitter<StatisticState> emitter,
  ) {
    final notesInRange = _filterByDateRange(event.newDateRange);
    emitter(
      StatisticState$Data(
        notes: state.notes,
        notesCount: notesInRange.length,
        averageMood: _calculateAverageMood(notesInRange),
        activityCount: _countActivity(notesInRange),
        moodsCount: _countMoods(notesInRange),
        dateRange: event.newDateRange,
      ),
    );
  }

  List<NoteModel> _filterByDateRange(DateTimeRange dateRange) {
    final startDate = dateRange.start.withoutTime();
    final endDate = dateRange.end.endOfDay();
    return state.notes
        .where(
          (note) =>
              (note.date.isAfter(startDate) ||
                  note.date.isAtSameMomentAs(startDate)) &&
              (note.date.isAtSameMomentAs(endDate) ||
                  note.date.isBefore(endDate)),
        )
        .toList();
  }

  Map<String, double> _countMoods(Iterable<NoteModel> notes) {
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

  int _countActivity(Iterable<NoteModel> notes) {
    if (notes.isEmpty) return 0;
    return notes.length * 2;
  }
}
