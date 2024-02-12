import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/food_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/mood_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/moods_storage.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/sleep_model.dart';
import 'package:daylio_clone/src/features/notes/domain/provider/notes_details_provider/note_details_events.dart';
import 'package:daylio_clone/src/features/notes/domain/provider/notes_details_provider/note_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesDetailsBloc extends Bloc<NoteDetailsEvents, NoteDetailsState> {
  final NotesRepository _notesRepository;

  NotesDetailsBloc({required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        super(NoteDetailsStateInitial()) {
    on<NoteDetailsEvents>((event, emitter) {
      switch (event) {
        case NoteDetailsLoadNoteEvent():
          _loadNote(event, emitter);
        case NoteDetailsDateChangeEvent():
          _onDateChange(event, emitter);
        case NoteDetailsTimeChangeEvent():
          _onTimeChange(event, emitter);
        case NoteDetailsMoodChangeEvent():
          _onMoodChange(event, emitter);
        case NoteDetailsSleepChangeGradeEvent():
          _onSleepGradeChange(event, emitter);
        case NoteDetailsSleepChangeDescriptionEvent():
          _onSleepDescriptionChange(event, emitter);
        case NoteDetailsFoodChangeGradeEvent():
          _onFoodGradeChange(event, emitter);
        case NoteDetailsFoodChangeDescriptionEvent():
          _onFoodDescriptionChange(event, emitter);
        case NoteDetailsSaveEvent():
          _onSave(event, emitter);
        case NoteDetailsDeleteEvent():
        // TODO: Handle this case.
      }
    });
  }

  Future<void> _loadNote(
      NoteDetailsLoadNoteEvent event, Emitter<NoteDetailsState> emitter) async {
    try {
      final note = await _notesRepository.readNote(event.noteId);
      emitter(NoteDetailsStateData(
        note: note,
        date: note.date,
        moodId: note.mood.id,
        sleepId: note.sleep.id,
        sleepDescription: note.sleep.description,
        foodId: note.food.id,
        foodDescription: note.food.description,
      ));
    } catch (e, s) {
      emitter(NoteDetailsStateError(
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
          month: event.date.day,
          year: event.date.year,
        ),
      ),
    );
  }

  void _onTimeChange(
    NoteDetailsTimeChangeEvent event,
    Emitter<NoteDetailsState> emitter,
  ) {
    emitter(state.copyWith(
        date: state.date.copyWith(
      hour: event.time.hour,
      minute: event.time.minute,
    )));
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
    try{
      if (state.note?.id == null) return;
      final note = NoteModel(
        id: state.note?.id,
        mood: MoodModel.fromEnum(MoodsStorage.values[state.moodId]),
        sleep: SleepModel.fromGradeAndDesc(
          id: state.sleepId,
          description: state.sleepDescription,
        ),
        food: FoodModel.fromGradeAndDesc(
            id: state.foodId, description: state.foodDescription),
        date: state.date,
      );
      await _notesRepository.updateNote(note);
    } catch (e, s) {
      emitter(NoteDetailsStateError(
        note: state.note,
        date: state.date,
        moodId: state.moodId,
        sleepId: state.sleepId,
        sleepDescription: state.sleepDescription,
        foodId: state.foodId,
        foodDescription: state.foodDescription,
        message: 'При сохранении данных произошла ошибка',
      ));
      Error.throwWithStackTrace(e, s);
    }
  }
}
//   NotesDetailsProvider({
//     required NotesRepository notesRepository,
//     required int id,
//   })  : _notesRepository = notesRepository,
//         state = NoteDetailsStateInitial() {
//     readNote(id);
//   }
//
//   Future<void> readNote(int id) async {
//     try {
//       final note = await _notesRepository.readNote(id);
//       state = NoteDetailsStateData(
//         note: note,
//         date: note.date,
//         moodId: note.mood.id,
//         sleepId: note.sleep.id,
//         sleepDescription: note.sleep.description,
//         foodId: note.food.id,
//         foodDescription: note.food.description,
//       );
//       notifyListeners();
//     } on Object catch (e, s) {
//       state = NoteDetailsStateError(
//         date: state.date,
//         moodId: state.moodId,
//         sleepId: state.sleepId,
//         sleepDescription: state.sleepDescription,
//         foodId: state.foodId,
//         foodDescription: state.foodDescription,
//         message: 'При загрузке данных произошла ошибка',
//       );
//       notifyListeners();
//       Error.throwWithStackTrace(e, s);
//     }
//   }
//
//   void updateDate(DateTime date) {
//     state = state.copyWith(
//         date: state.date
//             .copyWith(day: date.day, month: date.month, year: date.year));
//     notifyListeners();
//   }
//
//   void updateTime(TimeOfDay time) {
//     state = state.copyWith(
//         date: state.date.copyWith(hour: time.hour, minute: time.minute));
//     notifyListeners();
//   }
//
//   Future<void> updateMood(int id) async {
//     if (id == state.moodId) return;
//     state = state.copyWith(
//       moodId: id,
//     );
//     notifyListeners();
//   }
//
//   Future<void> updateSleepGrade(int sleepId) async {
//     state = state.copyWith(
//       sleepId: sleepId,
//     );
//     notifyListeners();
//   }
//
//   Future<void> updateSleepDescription(String v) async {
//     state = state.copyWith(sleepDescription: v);
//     notifyListeners();
//   }
//
//   Future<void> updateFoodGrade(int foodId) async {
//     state = state.copyWith(foodId: foodId);
//     notifyListeners();
//   }
//
//   Future<void> updateFoodDescription(String v) async {
//     state = state.copyWith(foodDescription: v);
//     notifyListeners();
//   }
//
//   Future<void> updateNote() async {
//     try {
//       final note = state.note?.copyWith(
//         date: state.date,
//         // mood: moods[state.moodId],
//         sleep: state.note?.sleep.copyWith(
//             id: state.sleepId,
//             title: GradeLabel.values[state.sleepId].title,
//             color: GradeLabel.values[state.sleepId].color,
//             description: state.sleepDescription),
//         food: state.note?.food.copyWith(
//             id: state.foodId,
//             title: GradeLabel.values[state.foodId].title,
//             color: GradeLabel.values[state.foodId].color,
//             description: state.foodDescription),
//       );
//       if (note == null) throw NoteNullException();
//       await _notesRepository.updateNote(note);
//       notifyListeners();
//     } on Object catch (e, s) {
//       state = NoteDetailsStateError(
//         date: state.date,
//         moodId: state.moodId,
//         sleepId: state.sleepId,
//         sleepDescription: state.sleepDescription,
//         foodId: state.foodId,
//         foodDescription: state.foodDescription,
//         message: 'При сохранении данных произошла ошибка',
//       );
//       notifyListeners();
//       Error.throwWithStackTrace(e, s);
//     }
//   }
//
//   Future<void> deleteNote() async {
//     try {
//       final id = state.note?.id;
//       if (id == null) throw NoteNullException();
//       await _notesRepository.deleteNote(id);
//       notifyListeners();
//     } on Object catch (e, s) {
//       state = NoteDetailsStateError(
//         date: state.date,
//         moodId: state.moodId,
//         sleepId: state.sleepId,
//         sleepDescription: state.sleepDescription,
//         foodId: state.foodId,
//         foodDescription: state.foodDescription,
//         message: 'При удалении данных произошла ошибка',
//       );
//       notifyListeners();
//       Error.throwWithStackTrace(e, s);
//     }
//   }
// }
