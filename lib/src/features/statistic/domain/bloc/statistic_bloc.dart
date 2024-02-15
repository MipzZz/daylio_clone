import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';

part 'statistic_event.dart';

part 'statistic_state.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  final NotesRepository _notesRepository;

  StatisticBloc({required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        super(StatisticState$Initial()) {
    on<StatisticEvent>(
      (event, emitter) => switch (event) {
        StatisticEvent$Calculate event => _calculateStatistic(event, emitter),
      },
    );
    _notesRepository.notesStream.listen(
      (notes) => add(StatisticEvent$Calculate()),
    );
  }

  Future<void> _calculateStatistic(
    StatisticEvent event,
    Emitter<StatisticState> emitter,
  ) async {
    try {
      emitter(StatisticState$Progress(
        notesCount: state.notesCount,
        averageMood: state.averageMood,
        activityCount: state.activityCount,
      ));

      final notes = await _notesRepository.readNotes();
      final averageMood = _calculateAverageMood(notes);
      final activityCount = _activityCount(notes);

      emitter(StatisticState$Data(
        notesCount: notes.length,
        averageMood: averageMood,
        activityCount: activityCount,
      ));
    } on Object catch (e, s) {
      emitter(StatisticState$Error(
        notesCount: state.notesCount,
        averageMood: state.averageMood,
        activityCount: state.activityCount,
        message: 'При обновлении статистики произошла ошибка',
      ));
      Error.throwWithStackTrace(e, s);
    }
  }

  double _calculateAverageMood(Iterable<NoteModel> notes) {
    if (notes.length < 3) return 0.0;
    final moodIdList = notes.map((e) => e.mood.id);
    final averageMood =
        (moodIdList.reduce((value, element) => value + element)) / notes.length;
    return 5 - averageMood;
  }

  //TODO доработать подсчет активностей

  int _activityCount(Iterable<NoteModel> notes) {
    var counter = 0;
    for (var note in notes) {
      if (note.food != null) counter += 1;
      if (note.sleep != null) counter += 1;
    }
    return counter;
  }
}
