import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';

part 'statistic_event.dart';

part 'statistic_state.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  StatisticBloc({required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        super(StatisticState$Initial()) {
    on<StatisticEvent>(
      (event, emitter) => switch (event) {
        final StatisticEvent$Initialize event =>
          _calculateStatistic(event, emitter),
        final StatisticEvent$Update event =>
          _reCalculateStatistic(event, emitter),
      },
      transformer: sequential(),
    );
    _notesRepository.notesStream.listen(
      (notes) => add(StatisticEvent$Update(notes)),
    );
  }

  final NotesRepository _notesRepository;

  Future<void> _calculateStatistic(
    StatisticEvent event,
    Emitter<StatisticState> emitter,
  ) async {
    try {
      emitter(
        StatisticState$Progress(
          notesCount: state.notesCount,
          averageMood: state.averageMood,
          activityCount: state.activityCount,
        ),
      );

      final notes = await _notesRepository.readNotes();
      final averageMood = _calculateAverageMood(notes);
      final activityCount = _activityCount(notes);

      emitter(
        StatisticState$Data(
          notesCount: notes.length,
          averageMood: averageMood,
          activityCount: activityCount,
        ),
      );
    } on Object{
      emitter(
        StatisticState$Error(
          notesCount: state.notesCount,
          averageMood: state.averageMood,
          activityCount: state.activityCount,
          message: 'При обновлении статистики произошла ошибка',
        ),
      );
      rethrow;
    }
  }

  void _reCalculateStatistic(
    StatisticEvent$Update event,
    Emitter<StatisticState> emitter,
  ) {
    final averageMood = _calculateAverageMood(event.notes);
    final activityCount = _activityCount(event.notes);
    emitter(
      StatisticState$Data(
        notesCount: event.notes.length,
        averageMood: averageMood,
        activityCount: activityCount,
      ),
    );
  }

  double _calculateAverageMood(Iterable<NoteModel> notes) {
    if (notes.length < 3) return 0.0;
    final moodIdList = notes.map((e) => e.mood.id);
    final averageMood =
        (moodIdList.reduce((value, element) => value + element)) / notes.length;
    return 5 - averageMood;
  }


  int _activityCount(Iterable<NoteModel> notes) => notes.length * 2;
}
