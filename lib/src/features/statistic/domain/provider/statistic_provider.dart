import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';
import 'package:daylio_clone/src/features/statistic/domain/provider/statistic_state.dart';
import 'package:flutter/material.dart';

class StatisticProvider extends ChangeNotifier {
  final NotesRepository _notesRepository;
  StatisticState state;

  StatisticProvider({required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        state = StatisticStateInitial() {
    calculateStatistic();
    _notesRepository.notesStream.listen(_reCalculateStatistic);
  }

  Future<void> calculateStatistic() async {
    try {
      final notes = await _notesRepository.readNotes();
      final averageMood = _calculateAverageMood(notes);
      final activityCount = _activityCount(notes);
      state = StatisticStateData(
          notesCount: notes.length,
          averageMood: averageMood,
          activityCount: activityCount);
      notifyListeners();
    } on Object catch (e, s) {
      state = StatisticStateError(
        averageMood: state.averageMood,
        notesCount: state.notesCount,
        activityCount: state.activityCount,
        message: 'К сожалению, не получилось загрузить статистику',
      );
      notifyListeners();
      Error.throwWithStackTrace(e, s);
    }
  }

  Future<void> _reCalculateStatistic(Iterable<NoteModel> notes) async {
    state = state.copyWith(
        notesCount: notes.length, averageMood: _calculateAverageMood(notes), activityCount: _activityCount(notes));
    notifyListeners();
  }

  double _calculateAverageMood(Iterable<NoteModel> notes) {
    if (notes.length < 3) return 0.0;
    final moodIdList = notes.map((e) => e.mood.id);
    final averageMood =
        (moodIdList.reduce((value, element) => value + element)) / notes.length;
    return 5 - averageMood;
  }

  int _activityCount(Iterable<NoteModel> notes) {
    var counter = 0;
    for (var note in notes){
      if(note.food != null) counter += 1;
      if(note.sleep != null) counter += 1;
    }
    return counter;
  }
}
