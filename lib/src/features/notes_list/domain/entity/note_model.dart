import '../../../../core/data/source/local/db/drift_storage.dart';

class NoteModel {
  final int id;
  final String mood;
  final String sleep;
  final String food;

  NoteModel(this.id, this.mood, this.sleep, this.food);

  NoteModel.fromNotebaleData(NoteTableData note) : this(note.id, note.mood, note.sleep, note.food);
}