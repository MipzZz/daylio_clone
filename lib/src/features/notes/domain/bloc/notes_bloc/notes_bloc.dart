import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_bloc/notes_event.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_bloc/notes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc({required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        super(NotesState$Initial()) {
    on<NotesEvent>(
      (event, emitter) => switch (event) {
        final NotesEvent$Read event => _readNotes(event, emitter),
        final NotesEvent$Refresh event => _readNotes(event, emitter),
        final NotesEvent$Update event => _updateNotes(event, emitter),
        final NotesEvent$Delete event => _deleteNote(event, emitter),
        final NotesEvent$AddTime event => _addTime(event, emitter),
        final NotesEvent$ReduceTime event => _reduceTime(event, emitter)
      },
      transformer: sequential(),
    );
    _notesRepository.notesStream.listen(
      (notes) => add(NotesEvent$Update(notes)),
    );
  }

  final NotesRepository _notesRepository;

  void _addTime(
    NotesEvent$AddTime event,
    Emitter<NotesState> emitter,
  ) {
    emitter(
      state.copyWith(
        date: state.date.copyWith(month: state.date.month + 1),
      ),
    );
  }

  void _reduceTime(
    NotesEvent$ReduceTime event,
    Emitter<NotesState> emitter,
  ) {
    emitter(
      state.copyWith(
        date: state.date.copyWith(month: state.date.month - 1),
      ),
    );
  }

  Future<void> _readNotes(
    NotesEvent event,
    Emitter<NotesState> emitter,
  ) async {
    try {
      if (event is NotesEvent$Refresh) {
        emitter(
          NotesState$Refreshing(notes: state.notes, date: state.date),
        );
      } else {
        emitter(NotesState$Progress(notes: state.notes, date: state.date));
      }
      final notes = await _notesRepository.readNotes();
      emitter(NotesState$Data(notes: notes.toList(), date: state.date));
    } on Object {
      emitter(
        NotesState$Error(
          notes: state.notes,
          date: state.date,
          message: 'При загрузке данных произошла ошибка. '
              'Пожалуйста, попробуйте повторить позже',
        ),
      );
      rethrow;
    }
  }

  Future<void> _deleteNote(
    NotesEvent$Delete event,
    Emitter<NotesState> emitter,
  ) async {
    try {
      final id = event.noteId;
      if (id == null) return;
      state.notes.removeWhere((element) => id == element.id);
      emitter(NotesState$Data(notes: state.notes.toList(), date: state.date));
      await _notesRepository.deleteNote(id);
    } on Object {
      emitter(
        NotesState$Error(
          notes: state.notes,
          date: state.date,
          message: 'При удалении записи произошла ошибка',
        ),
      );
      rethrow;
    }
  }

  void _updateNotes(
    NotesEvent$Update event,
    Emitter<NotesState> emitter,
  ) {
    try {
      emitter(NotesState$Data(notes: event.notes.toList(), date: state.date));
    } on Object {
      emitter(
        NotesState$Error(
          notes: state.notes,
          date: state.date,
          message: 'При обновлении данных произошла ошибка',
        ),
      );
      rethrow;
    }
  }
}
