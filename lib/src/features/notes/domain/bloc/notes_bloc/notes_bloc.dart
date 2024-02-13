import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_bloc/notes_events.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_bloc/notes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository _notesRepository;

  NotesBloc({required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        super(NotesStateInitialize()) {
    on<NotesEvent>((event, emitter) => switch (event) {
          NotesEvent$Initialize event => _initialize(event, emitter),
          NotesEvent$Update event => _updateNotes(event, emitter),
        });
    _notesRepository.notesStream.listen((e) => add(NotesEvent$Update(e)));
  }

  Future<void> _initialize(
    NotesEvent$Initialize event,
    Emitter<NotesState> emitter,
  ) async {
    try {
      final notes = await _notesRepository.readNotes();

      emitter(NotesStateData(notes: notes.toList()));
    } on Object {
      emitter(
        const NotesStateError(
          notes: [],
          message: 'Loading failure',
        ),
      );
    }
  }

  Future<void> _updateNotes(
    NotesEvent$Update event,
    Emitter<NotesState> emitter,
  ) async {
    try {
      emitter(NotesStateData(notes: event.notes.toList()));
      // await emitter.forEach<Iterable<NoteModel>>(
      //   _notesRepository.notesStream,
      //   onData: (notes) => NotesStateData(
      //     notes: notes.toList(),
      //   ),
      //   onError: (e, s) => NotesStateError(
      //     notes: state.notes,
      //     message: '$e',
      //   ),
      // );
    } on Object catch (e, s) {
      emitter(
        NotesStateError(
          notes: state.notes,
          message: 'При загрузке данных произошла ошибка',
        ),
      );
      Error.throwWithStackTrace(e, s);
    }
  }
}
