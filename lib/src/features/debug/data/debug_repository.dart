import 'package:daylio_clone/src/core/data/source/local/db/drift_storage.dart';

class DebugRepository{

  DebugRepository({required AppDb driftStorage}) : _driftStorage = driftStorage;
  final AppDb _driftStorage;

  Future<void> dropTable() async {
    await _driftStorage.createAllTablesAgain();
  }
}
