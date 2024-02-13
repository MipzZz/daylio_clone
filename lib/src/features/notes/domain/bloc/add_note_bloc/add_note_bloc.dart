import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/food_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/mood_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/moods_storage.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/sleep_model.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/add_note_bloc/add_note_events.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/add_note_bloc/add_note_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  final NotesRepository _notesRepository;

  AddNoteBloc({required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        super(AddNoteStateNew(date: DateTime.now())) {
    on<AddNoteEvent>(
      (event, emitter) => switch (event) {
        AddNoteDateChangeEvent event => _onDateChange(event, emitter),
        AddNoteTimeChangeEvent event => _onTimeChange(event, emitter),
        AddNoteMoodChangeEvent event => _onMoodChange(event, emitter),
        AddNoteSleepChangeGradeEvent event =>
          _onSleepGradeChange(event, emitter),
        AddNoteSleepChangeDescriptionEvent event =>
          _onSleepDescriptionChange(event, emitter),
        AddNoteFoodChangeGradeEvent event => _onFoodGradeChange(event, emitter),
        AddNoteFoodChangeDescriptionEvent event =>
          _onFoodDescriptionChange(event, emitter),
        AddNoteSubmitEvent event => _onAddNoteSubmit(event, emitter)
      },
      transformer: sequential(),
    );
  }

  void _onDateChange(
    AddNoteDateChangeEvent event,
    Emitter<AddNoteState> emitter,
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
    AddNoteTimeChangeEvent event,
    Emitter<AddNoteState> emitter,
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
    AddNoteMoodChangeEvent event,
    Emitter<AddNoteState> emitter,
  ) {
    emitter(
      state.copyWith(
        moodId: event.moodId,
      ),
    );
  }

  void _onSleepGradeChange(
    AddNoteSleepChangeGradeEvent event,
    Emitter<AddNoteState> emitter,
  ) {
    emitter(
      state.copyWith(
        sleepId: event.sleepId,
      ),
    );
  }

  void _onSleepDescriptionChange(
    AddNoteSleepChangeDescriptionEvent event,
    Emitter<AddNoteState> emitter,
  ) {
    emitter(
      state.copyWith(
        sleepDescription: event.sleepDescription,
      ),
    );
  }

  void _onFoodGradeChange(
    AddNoteFoodChangeGradeEvent event,
    Emitter<AddNoteState> emitter,
  ) {
    emitter(
      state.copyWith(
        foodId: event.foodId,
      ),
    );
  }

  void _onFoodDescriptionChange(
    AddNoteFoodChangeDescriptionEvent event,
    Emitter<AddNoteState> emitter,
  ) {
    emitter(
      state.copyWith(
        foodDescription: event.foodDescription,
      ),
    );
  }

  Future<void> _onAddNoteSubmit(
    AddNoteSubmitEvent event,
    Emitter<AddNoteState> emitter,
  ) async {
    try {
      final note = NoteModel(
        id: null,
        mood: MoodModel.fromEnum(MoodsStorage.values[state.moodId]),
        sleep: SleepModel.fromGradeAndDesc(
          id: state.sleepId,
          description: state.sleepDescription,
        ),
        food: FoodModel.fromGradeAndDesc(
            id: state.foodId, description: state.foodDescription),
        date: state.date,
      );
      await _notesRepository.saveNote(note);
    } on Object catch (e, s) {
      emitter(
        AddNoteStateError(
          date: state.date,
          moodId: state.moodId,
          sleepId: state.sleepId,
          sleepDescription: state.sleepDescription,
          foodId: state.foodId,
          foodDescription: state.foodDescription,
          message: 'При сохранении данных произошла ошибка',
        ),
      );
      Error.throwWithStackTrace(e, s);
    }
  }
}
