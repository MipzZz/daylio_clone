import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:daylio_clone/src/core/utils/exceptions/note_null_exception.dart';
import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/food_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/mood_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/moods_storage.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/sleep_model.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_details_bloc/note_details_events.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_details_bloc/note_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteDetailsBloc extends Bloc<NoteDetailsEvents, NoteDetailsState> {
  final NotesRepository _notesRepository;
  late final NoteModel note;

  NoteDetailsBloc({required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        super(NoteDetailsState$Initial()) {
    on<NoteDetailsEvents>(
      (event, emitter) => switch (event) {
        NoteDetailsLoadNoteEvent() => _loadNote(event, emitter),
        NoteDetailsDateChangeEvent() => _onDateChange(event, emitter),
        NoteDetailsTimeChangeEvent() => _onTimeChange(event, emitter),
        NoteDetailsMoodChangeEvent() => _onMoodChange(event, emitter),
        NoteDetailsSleepChangeGradeEvent() =>
          _onSleepGradeChange(event, emitter),
        NoteDetailsSleepChangeDescriptionEvent() =>
          _onSleepDescriptionChange(event, emitter),
        NoteDetailsFoodChangeGradeEvent() => _onFoodGradeChange(event, emitter),
        NoteDetailsFoodChangeDescriptionEvent() =>
          _onFoodDescriptionChange(event, emitter),
        NoteDetailsSaveEvent() => _onSave(event, emitter),
        NoteDetailsDeleteEvent() => _onDelete(event, emitter),
      },
      transformer: sequential(),
    );
  }

  Future<void> _loadNote(
      NoteDetailsLoadNoteEvent event, Emitter<NoteDetailsState> emitter) async {
    try {
      note = await _notesRepository.readNote(event.noteId);
      emitter(NoteDetailsState$Data(
        note: note,
        date: note.date,
        moodId: note.mood.id,
        sleepId: note.sleep.id,
        sleepDescription: note.sleep.description,
        foodId: note.food.id,
        foodDescription: note.food.description,
      ));
    } on Object catch (e, s) {
      emitter(NoteDetailsState$Error(
        note: state.note,
        date: state.date,
        moodId: state.moodId,
        sleepId: state.sleepId,
        sleepDescription: state.sleepDescription,
        foodId: state.foodId,
        foodDescription: state.foodDescription,
        message: 'При загрузке данных произошла ошибка',
      ));
      Error.throwWithStackTrace(e, s);
    }
  }

  void _onDateChange(
    NoteDetailsDateChangeEvent event,
    Emitter<NoteDetailsState> emitter,
  ) {
    emitter(
      state.copyWith(
        date: state.date.copyWith(
          day: event.date.day,
          month: event.date.month,
          year: event.date.year,
        ),
      ),
    );
  }

  void _onTimeChange(
    NoteDetailsTimeChangeEvent event,
    Emitter<NoteDetailsState> emitter,
  ) {
    emitter(
      state.copyWith(
        date: state.date.copyWith(
          hour: event.time.hour,
          minute: event.time.minute,
        ),
      ),
    );
  }

  void _onMoodChange(
    NoteDetailsMoodChangeEvent event,
    Emitter<NoteDetailsState> emitter,
  ) {
    emitter(state.copyWith(
      moodId: event.moodId,
    ));
  }

  void _onSleepGradeChange(
    NoteDetailsSleepChangeGradeEvent event,
    Emitter<NoteDetailsState> emitter,
  ) {
    emitter(state.copyWith(
      sleepId: event.sleepId,
    ));
  }

  void _onSleepDescriptionChange(
    NoteDetailsSleepChangeDescriptionEvent event,
    Emitter<NoteDetailsState> emitter,
  ) {
    emitter(state.copyWith(
      sleepDescription: event.sleepDescription,
    ));
  }

  void _onFoodGradeChange(
    NoteDetailsFoodChangeGradeEvent event,
    Emitter<NoteDetailsState> emitter,
  ) {
    emitter(state.copyWith(
      foodId: event.foodId,
    ));
  }

  void _onFoodDescriptionChange(
    NoteDetailsFoodChangeDescriptionEvent event,
    Emitter<NoteDetailsState> emitter,
  ) {
    emitter(state.copyWith(
      foodDescription: event.foodDescription,
    ));
  }

  Future<void> _onSave(
    NoteDetailsSaveEvent event,
    Emitter<NoteDetailsState> emitter,
  ) async {
    try {
      if (note.id == null) throw NoteNullException();
      final updatedNote = NoteModel(
        id: note.id,
        mood: MoodModel.fromEnum(MoodsStorage.values[state.moodId]),
        sleep: SleepModel.fromGradeAndDesc(
          id: state.sleepId,
          description: state.sleepDescription,
        ),
        food: FoodModel.fromGradeAndDesc(
            id: state.foodId, description: state.foodDescription),
        date: state.date,
      );

      emitter(NoteDetailsState$Progress(
        note: updatedNote,
        date: state.date,
        moodId: state.moodId,
        sleepId: state.sleepId,
        sleepDescription: state.sleepDescription,
        foodId: state.foodId,
        foodDescription: state.foodDescription,
      ));

      await _notesRepository.updateNote(updatedNote);

      emitter(NoteDetailsState$Completed(
        note: updatedNote,
        date: state.date,
        moodId: state.moodId,
        sleepId: state.sleepId,
        sleepDescription: state.sleepDescription,
        foodId: state.foodId,
        foodDescription: state.foodDescription,
      ));

    } on Object catch (e, s) {
      emitter(NoteDetailsState$Error(
        note: note,
        date: state.date,
        moodId: state.moodId,
        sleepId: state.sleepId,
        sleepDescription: state.sleepDescription,
        foodId: state.foodId,
        foodDescription: state.foodDescription,
        message: 'При сохранении данных произошла ошибка',
      ));
      Error.throwWithStackTrace(e, s);
    } finally {{
        emitter(NoteDetailsState$Data(
          note: note,
          date: state.date,
          moodId: state.moodId,
          sleepId: state.sleepId,
          sleepDescription: state.sleepDescription,
          foodId: state.foodId,
          foodDescription: state.foodDescription,
        ));
      }
    }
  }

  Future<void> _onDelete(
    NoteDetailsDeleteEvent event,
    Emitter<NoteDetailsState> emitter,
  ) async {
    try {
      final id = state.note?.id;
      if (id == null) throw NoteNullException();

      emitter(NoteDetailsState$Progress(
        note: note,
        date: state.date,
        moodId: state.moodId,
        sleepId: state.sleepId,
        sleepDescription: state.sleepDescription,
        foodId: state.foodId,
        foodDescription: state.foodDescription,
      ));


      await _notesRepository.deleteNote(id);

      emitter(NoteDetailsState$Completed(
        note: note,
        date: state.date,
        moodId: state.moodId,
        sleepId: state.sleepId,
        sleepDescription: state.sleepDescription,
        foodId: state.foodId,
        foodDescription: state.foodDescription,
      ));

    } on Object catch (e, s) {
      emitter(
        NoteDetailsState$Error(
          note: note,
          date: state.date,
          moodId: state.moodId,
          sleepId: state.sleepId,
          sleepDescription: state.sleepDescription,
          foodId: state.foodId,
          foodDescription: state.foodDescription,
          message: 'При удалении данных произошла ошибка',
        ),
      );
      Error.throwWithStackTrace(e, s);
    } finally {
        emitter(NoteDetailsState$Data(
          note: note,
          date: state.date,
          moodId: state.moodId,
          sleepId: state.sleepId,
          sleepDescription: state.sleepDescription,
          foodId: state.foodId,
          foodDescription: state.foodDescription,
        ));
      }
    }
  }

