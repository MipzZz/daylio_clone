import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';
import 'package:daylio_clone/src/features/notes/domain/provider/notes_bloc/notes_events.dart';
import 'package:daylio_clone/src/features/notes/domain/provider/notes_bloc/notes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesBloc extends Bloc<NotesEvents, NotesState> {
  final NotesRepository _notesRepository;

  NotesBloc({required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        super(NotesStateInitialize()) {
    on<NoteEventsSubscriptionRequestEvent>(_loadNotes);
  }

  Future<void> _loadNotes(
    NoteEventsSubscriptionRequestEvent event,
    Emitter<NotesState> emitter,
  ) async {
    try {
      await emitter.forEach<Iterable<NoteModel>>(
        _notesRepository.notesStream,
        onData: (notes) => NotesStateData(
          notes: notes.toList(),
        ),
      );
    } catch (e, s) {
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
