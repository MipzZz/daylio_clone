import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/food_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/mood_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/moods_storage.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/sleep_model.dart';
import 'package:daylio_clone/src/features/notes/domain/provider/add_note_bloc/add_note_events.dart';
import 'package:daylio_clone/src/features/notes/domain/provider/add_note_bloc/add_note_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNoteBloc extends Bloc<AddNoteEvents, AddNoteState> {
  final NotesRepository _notesRepository;

  AddNoteBloc({required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        super(
          AddNoteStateNew(
            date: DateTime.now(),
            moodId: 0,
            foodId: 0,
            foodDescription: '',
            sleepId: 0,
            sleepDescription: '',
          ),
        ) {
    on<AddNoteEvents>((event, emitter) {
      switch (event) {
        case AddNoteDateChangeEvent():
          _onDateChange(event, emitter);
        case AddNoteTimeChangeEvent():
          _onTimeChange(event, emitter);
        case AddNoteMoodChangeEvent():
          _onMoodChange(event, emitter);
        case AddNoteSleepChangeGradeEvent():
          _onSleepGradeChange(event, emitter);
        case AddNoteSleepChangeDescriptionEvent():
          _onSleepDescriptionChange(event, emitter);
        case AddNoteFoodChangeGradeEvent():
          _onFoodGradeChange(event, emitter);
        case AddNoteFoodChangeDescriptionEvent():
          _onFoodDescriptionChange(event, emitter);
        case AddNoteSubmitEvent():
          _onAddNoteSubmit(event, emitter);
      }
    });
  }

  void _onDateChange(
    AddNoteDateChangeEvent event,
    Emitter<AddNoteState> emitter,
  ) {
    emitter(
      state.copyWith(
        date: state.date.copyWith(
          day: event.date.day,
          month: event.date.day,
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
    } catch (e) {
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
    }
  }
}