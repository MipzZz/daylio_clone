import 'package:collection/collection.dart';
import 'package:daylio_clone/src/core/utils/extensions/date_time_extension.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';

sealed class NotesState {
  List<NoteModel> get notes;

  List<NoteModel> get sortedNotes;

  Map<DateTime, List<NoteModel>> get groupedNotes;

  DateTime get date;

  NotesState copyWith({
    List<NoteModel>? notes,
    DateTime? date,
  });
}

final class NotesState$Initial implements NotesState {
  @override
  List<NoteModel> get notes => [];

  @override
  List<NoteModel> get sortedNotes => [];

  @override
  Map<DateTime, List<NoteModel>> get groupedNotes => {};

  @override
  DateTime get date => DateTime.now();

  @override
  NotesState$Initial copyWith({
    List<NoteModel>? notes,
    DateTime? date,
  }) =>
      NotesState$Initial();
}

final class NotesState$Data implements NotesState {
  NotesState$Data({
    required this.notes,
    required this.date,
  }) {
    sortedNotes = notes.sorted((a, b) => b.date.compareTo(a.date));
    groupedNotes = groupBy(sortedNotes, (note) => note.date.withoutTime());
  }

  @override
  final List<NoteModel> notes;
  @override
  final DateTime date;
  @override
  late final List<NoteModel> sortedNotes;
  @override
  late final Map<DateTime, List<NoteModel>> groupedNotes;

  @override
  NotesState$Data copyWith({
    List<NoteModel>? notes,
    DateTime? date,
  }) =>
      NotesState$Data(
        notes: notes ?? this.notes,
        date: date ?? this.date,
      );
}

final class NotesState$Progress implements NotesState {
  NotesState$Progress({
    required this.notes,
    required this.date,
  }) {
    sortedNotes = notes.sorted((a, b) => b.date.compareTo(a.date));
    groupedNotes = groupBy(sortedNotes, (note) => note.date.withoutTime());
  }

  @override
  final List<NoteModel> notes;
  @override
  final DateTime date;
  @override
  late final List<NoteModel> sortedNotes;
  @override
  late final Map<DateTime, List<NoteModel>> groupedNotes;

  @override
  NotesState$Progress copyWith({
    List<NoteModel>? notes,
    DateTime? date,
  }) =>
      NotesState$Progress(
        notes: notes ?? this.notes,
        date: date ?? this.date,
      );
}

final class NotesState$Refreshing implements NotesState {
  NotesState$Refreshing({
    required this.notes,
    required this.date,
  }) {
    sortedNotes = notes.sorted((a, b) => b.date.compareTo(a.date));
    groupedNotes = groupBy(sortedNotes, (note) => note.date.withoutTime());
  }

  @override
  final List<NoteModel> notes;
  @override
  final DateTime date;
  @override
  late final List<NoteModel> sortedNotes;
  @override
  late final Map<DateTime, List<NoteModel>> groupedNotes;

  @override
  NotesState$Refreshing copyWith({
    List<NoteModel>? notes,
    DateTime? date,
  }) =>
      NotesState$Refreshing(
        notes: notes ?? this.notes,
        date: date ?? this.date,
      );
}

final class NotesState$Error implements NotesState {
  NotesState$Error({
    required this.notes,
    required this.date,
    required this.message,
  }) {
    sortedNotes = notes.sorted((a, b) => b.date.compareTo(a.date));
    groupedNotes = groupBy(sortedNotes, (note) => note.date.withoutTime());
  }

  @override
  final List<NoteModel> notes;
  @override
  final DateTime date;
  @override
  late final List<NoteModel> sortedNotes;
  @override
  late final Map<DateTime, List<NoteModel>> groupedNotes;
  final String message;

  @override
  NotesState$Error copyWith({
    List<NoteModel>? notes,
    DateTime? date,
    String? message,
  }) =>
      NotesState$Error(
        notes: notes ?? this.notes,
        date: date ?? this.date,
        message: message ?? this.message,
      );
}
