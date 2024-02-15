import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:daylio_clone/src/core/utils/exceptions/note_null_exception.dart';
import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_details_bloc/note_details_event.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_details_bloc/note_details_state.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/food_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/mood_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/moods_storage.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/sleep_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteDetailsBloc extends Bloc<NoteDetailsEvent, NoteDetailsState> {

  NoteDetailsBloc({required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        super(NoteDetailsState$Initial()) {
    on<NoteDetailsEvent>(
      (event, emitter) => switch (event) {
        NoteDetailsEvent$LoadNote() => _loadNote(event, emitter),
        NoteDetailsEvent$DateChange() => _onDateChange(event, emitter),
        NoteDetailsEvent$TimeChange() => _onTimeChange(event, emitter),
        NoteDetailsEvent$MoodChange() => _onMoodChange(event, emitter),
        NoteDetailsEvent$SleepGradeChange() =>
          _onSleepGradeChange(event, emitter),
        NoteDetailsEvent$SleepDescriptionChange() =>
          _onSleepDescriptionChange(event, emitter),
        NoteDetailsEvent$FoodGradeChange() => _onFoodGradeChange(event, emitter),
        NoteDetailsEvent$FoodDescriptionChange() =>
          _onFoodDescriptionChange(event, emitter),
        NoteDetailsEvent$Save() => _onSave(event, emitter),
        NoteDetailsEvent$Delete() => _onDelete(event, emitter),
      },
      transformer: sequential(),
    );
  }
  final NotesRepository _notesRepository;
  late final NoteModel note;

  Future<void> _loadNote(
      NoteDetailsEvent$LoadNote event, Emitter<NoteDetailsState> emitter,) async {
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
      ),);
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
      ),);
      Error.throwWithStackTrace(e, s);
    }
  }

  void _onDateChange(
    NoteDetailsEvent$DateChange event,
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
    NoteDetailsEvent$TimeChange event,
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
    NoteDetailsEvent$MoodChange event,
    Emitter<NoteDetailsState> emitter,
  ) {
    emitter(state.copyWith(
      moodId: event.moodId,
    ),);
  }

  void _onSleepGradeChange(
    NoteDetailsEvent$SleepGradeChange event,
    Emitter<NoteDetailsState> emitter,
  ) {
    emitter(state.copyWith(
      sleepId: event.sleepId,
    ),);
  }

  void _onSleepDescriptionChange(
    NoteDetailsEvent$SleepDescriptionChange event,
    Emitter<NoteDetailsState> emitter,
  ) {
    emitter(state.copyWith(
      sleepDescription: event.sleepDescription,
    ),);
  }

  void _onFoodGradeChange(
    NoteDetailsEvent$FoodGradeChange event,
    Emitter<NoteDetailsState> emitter,
  ) {
    emitter(state.copyWith(
      foodId: event.foodId,
    ),);
  }

  void _onFoodDescriptionChange(
    NoteDetailsEvent$FoodDescriptionChange event,
    Emitter<NoteDetailsState> emitter,
  ) {
    emitter(state.copyWith(
      foodDescription: event.foodDescription,
    ),);
  }

  Future<void> _onSave(
    NoteDetailsEvent$Save event,
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
            id: state.foodId, description: state.foodDescription,),
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
      ),);

      await _notesRepository.updateNote(updatedNote);

      emitter(NoteDetailsState$Completed(
        note: updatedNote,
        date: state.date,
        moodId: state.moodId,
        sleepId: state.sleepId,
        sleepDescription: state.sleepDescription,
        foodId: state.foodId,
        foodDescription: state.foodDescription,
      ),);

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
      ),);
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
        ),);
      }
    }
  }

  Future<void> _onDelete(
    NoteDetailsEvent$Delete event,
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
      ),);


      await _notesRepository.deleteNote(id);

      emitter(NoteDetailsState$Completed(
        note: note,
        date: state.date,
        moodId: state.moodId,
        sleepId: state.sleepId,
        sleepDescription: state.sleepDescription,
        foodId: state.foodId,
        foodDescription: state.foodDescription,
      ),);

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
        ),);
      }
    }
  }
