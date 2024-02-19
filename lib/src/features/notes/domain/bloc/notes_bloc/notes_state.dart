import 'package:collection/collection.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';

sealed class NotesState {
  List<NoteModel> get notes;

  List<NoteModel> get sortedNotes;

  NotesState copyWith({
    List<NoteModel>? notes,
  });
}

final class NotesState$Initial implements NotesState {
  @override
  List<NoteModel> get notes => [];

  @override
  List<NoteModel> get sortedNotes => [];

  @override
  NotesState$Initial copyWith({
    List<NoteModel>? notes,
  }) =>
      NotesState$Initial();
}

final class NotesState$Data implements NotesState {
  NotesState$Data({
    required this.notes,
  }) {
    sortedNotes = notes.sorted((a, b) => a.date.compareTo(b.date));
  }

  @override
  final List<NoteModel> notes;
  @override
  late final List<NoteModel> sortedNotes;

  @override
  NotesState$Data copyWith({
    List<NoteModel>? notes,
  }) =>
      NotesState$Data(
        notes: notes ?? this.notes,
      );
}

final class NotesState$Progress implements NotesState {
  NotesState$Progress({
    required this.notes,
  }) {
    sortedNotes = notes.sorted((a, b) => a.date.compareTo(b.date));
  }

  @override
  final List<NoteModel> notes;
  @override
  late final List<NoteModel> sortedNotes;

  @override
  NotesState$Progress copyWith({
    List<NoteModel>? notes,
  }) =>
      NotesState$Progress(
        notes: notes ?? this.notes,
      );
}

final class NotesState$Refreshing implements NotesState {
  NotesState$Refreshing({
    required this.notes,
  }) {
    sortedNotes = notes.sorted((a, b) => a.date.compareTo(b.date));
  }

  @override
  final List<NoteModel> notes;
  @override
  late final List<NoteModel> sortedNotes;

  @override
  NotesState$Refreshing copyWith({
    List<NoteModel>? notes,
  }) =>
      NotesState$Refreshing(
        notes: notes ?? this.notes,
      );
}

final class NotesState$Error implements NotesState {
  NotesState$Error({
    required this.notes,
    required this.message,
  }) {
    sortedNotes = notes.sorted((a, b) => a.date.compareTo(b.date));
  }

  @override
  final List<NoteModel> notes;
  @override
  late final List<NoteModel> sortedNotes;
  final String message;

  @override
  NotesState$Error copyWith({
    List<NoteModel>? notes,
    String? message,
  }) =>
      NotesState$Error(
        notes: notes ?? this.notes,
        message: message ?? this.message,
      );
}
