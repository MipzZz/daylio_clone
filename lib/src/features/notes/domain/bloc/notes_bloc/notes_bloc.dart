import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_bloc/notes_event.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_bloc/notes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {

  NotesBloc({required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        super(NotesState$Initial()) {
    on<NotesEvent>((event, emitter) => switch (event) {
          final NotesEvent$Initialize event => _initialize(event, emitter),
          final NotesEvent$Update event => _updateNotes(event, emitter),
          final NotesEvent$Refresh event => _refreshNotes(event, emitter),
        },);
    _notesRepository.notesStream.listen(
      (notes) => add(NotesEvent$Update(notes)),
    );
  }
  final NotesRepository _notesRepository;

  // TODO(MipZ): решить проблему с повторяемым кодом
  // TODO(MipZ): copywith
  Future<void> _initialize(
    NotesEvent$Initialize event,
    Emitter<NotesState> emitter,
  ) async {
    try {
      emitter(NotesState$Progress(notes: state.notes));
      final notes = await _notesRepository.readNotes();
      emitter(NotesState$Data(notes: notes.toList()));
    } on Object catch (e, s) {
      emitter(
        const NotesState$Error(
          notes: [],
          message: 'При загрузке данных произошла ошибка. '
              'Пожалуйста, попробуйте повторить позже',
        ),
      );
      Error.throwWithStackTrace(e, s);
    }
  }

  void _updateNotes(
    NotesEvent$Update event,
    Emitter<NotesState> emitter,
  ) {
    try {
      emitter(NotesState$Data(notes: event.notes.toList()));
    } on Object catch (e, s) {
      emitter(
        NotesState$Error(
          notes: state.notes,
          message: 'При обновлении данных произошла ошибка',
        ),
      );
      Error.throwWithStackTrace(e, s);
    }
  }

  Future<void> _refreshNotes(
    NotesEvent$Refresh event,
    Emitter<NotesState> emitter,
  ) async {
    try {
      emitter(NotesState$Refreshing(notes: state.notes));
      final notes = await _notesRepository.readNotes();
      emitter(NotesState$Data(notes: notes.toList()));
    } on Object{
      emitter(const NotesState$Error(
        notes: [],
        message: 'При обновлении данных произошла ошибка',
      ),);
    }
  }
}
