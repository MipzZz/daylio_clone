import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/add_note_bloc/add_note_event.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/add_note_bloc/add_note_state.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/food_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/mood_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/moods_storage.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/sleep_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  AddNoteBloc({required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        super(AddNoteState$Idle(date: DateTime.now())) {
    on<AddNoteEvent>(
      (event, emitter) => switch (event) {
        final AddNoteEvent$DateChange event => _onDateChange(event, emitter),
        final AddNoteEvent$TimeChange event => _onTimeChange(event, emitter),
        final AddNoteEvent$MoodChange event => _onMoodChange(event, emitter),
        final AddNoteEvent$SleepGradeChange event =>
          _onSleepGradeChange(event, emitter),
        final AddNoteEvent$SleepDescriptionChange event =>
          _onSleepDescriptionChange(event, emitter),
        final AddNoteEvent$FoodGradeChange event =>
          _onFoodGradeChange(event, emitter),
        final AddNoteEvent$FoodDescriptionChange event =>
          _onFoodDescriptionChange(event, emitter),
        final AddNoteEvent$Submit event => _onAddNoteSubmit(event, emitter),
      },
      transformer: sequential(),
    );
  }

  final NotesRepository _notesRepository;

  void _onDateChange(
    AddNoteEvent$DateChange event,
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
    AddNoteEvent$TimeChange event,
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
    AddNoteEvent$MoodChange event,
    Emitter<AddNoteState> emitter,
  ) {
    emitter(
      state.copyWith(
        moodId: event.moodId,
      ),
    );
  }

  void _onSleepGradeChange(
    AddNoteEvent$SleepGradeChange event,
    Emitter<AddNoteState> emitter,
  ) {
    emitter(
      state.copyWith(
        sleepId: event.sleepId,
      ),
    );
  }

  void _onSleepDescriptionChange(
    AddNoteEvent$SleepDescriptionChange event,
    Emitter<AddNoteState> emitter,
  ) {
    emitter(
      state.copyWith(
        sleepDescription: event.sleepDescription,
      ),
    );
  }

  void _onFoodGradeChange(
    AddNoteEvent$FoodGradeChange event,
    Emitter<AddNoteState> emitter,
  ) {
    emitter(
      state.copyWith(
        foodId: event.foodId,
      ),
    );
  }

  void _onFoodDescriptionChange(
    AddNoteEvent$FoodDescriptionChange event,
    Emitter<AddNoteState> emitter,
  ) {
    emitter(
      state.copyWith(
        foodDescription: event.foodDescription,
      ),
    );
  }

  Future<void> _onAddNoteSubmit(
    AddNoteEvent$Submit event,
    Emitter<AddNoteState> emitter,
  ) async {
    try {
      emitter(
        AddNoteState$Progress(
          date: state.date,
          moodId: state.moodId,
          sleepId: state.sleepId,
          sleepDescription: state.sleepDescription,
          foodId: state.foodId,
          foodDescription: state.foodDescription,
        ),
      );

      final note = NoteModel(
        id: null,
        mood: MoodModel.fromEnum(MoodsStorage.values[state.moodId]),
        sleep: SleepModel.fromGradeAndDesc(
          id: state.sleepId,
          description: state.sleepDescription,
        ),
        food: FoodModel.fromGradeAndDesc(
          id: state.foodId,
          description: state.foodDescription,
        ),
        date: state.date,
      );
      await _notesRepository.saveNote(note);

      emitter(AddNoteState$Created());
    } on Object {
      emitter(
        AddNoteState$Error(
          date: state.date,
          moodId: state.moodId,
          sleepId: state.sleepId,
          sleepDescription: state.sleepDescription,
          foodId: state.foodId,
          foodDescription: state.foodDescription,
          message: 'При сохранении данных произошла ошибка',
        ),

      );
      rethrow;
    } finally {
      emitter(
        AddNoteState$Idle(
          date: state.date,
          moodId: state.moodId,
          sleepId: state.sleepId,
          sleepDescription: state.sleepDescription,
          foodId: state.foodId,
          foodDescription: state.foodDescription,
        ),
      );
    }
  }
}
