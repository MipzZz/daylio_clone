import 'package:daylio_clone/src/core/data/source/local/db/drift_storage.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';

class StatisticRepository {
  final AppDb _driftStorage;

  Future<Iterable<NoteModel>> readNotes() async {
    final updateNotes = await _driftStorage.readNotes();
    final notes = updateNotes.map(NoteModel.fromNoteTableData);
    return notes;
  }

  StatisticRepository({required AppDb database}) : _driftStorage = database;
}
