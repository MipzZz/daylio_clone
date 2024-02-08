import 'package:daylio_clone/src/core/data/source/local/db/drift_storage.dart';

class DebugRepository{
  final AppDb _driftStorage;

  DebugRepository({required AppDb driftStorage}) : _driftStorage = driftStorage;

  Future<void> dropTable() async {
    await _driftStorage.createAllTablesAgain();
  }
}