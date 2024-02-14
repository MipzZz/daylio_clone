import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_bloc/notes_events.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_bloc/notes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository _notesRepository;

  NotesBloc({required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        super(NotesState$Initialize()) {
    on<NotesEvent>((event, emitter) => switch (event) {
          NotesEvent$Initialize event => _initialize(event, emitter),
          NotesEvent$Update event => _updateNotes(event, emitter),
        });
    _notesRepository.notesStream.listen(
      (notes) => add(NotesEvent$Update(notes)),
    );
  }

  Future<void> _initialize(
    NotesEvent$Initialize event,
    Emitter<NotesState> emitter,
  ) async {
    try {
      final notes = await _notesRepository.readNotes();
      emitter(NotesState$Data(notes: notes.toList()));
    } on Object catch (e, s) {
      emitter(
        const NotesState$Error(
          notes: [],
          message: 'При загрузке данных произошла ошибка. '
              'Пожалуйста, попробуйте перезайти',
        ),
      );
      Error.throwWithStackTrace(e, s);
    }
  }

  Future<void> _updateNotes(
    NotesEvent$Update event,
    Emitter<NotesState> emitter,
  ) async {
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
    } finally{
      emitter(NotesState$Data(notes: event.notes.toList()));
    }
  }
}
