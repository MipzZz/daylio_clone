import 'package:daylio_clone/src/features/debug/data/debug_repository.dart';

class DebugProvider{

  DebugProvider({required DebugRepository debugRepository}): _debugRepository = debugRepository;
  final DebugRepository _debugRepository;

  void dropTables(){
    _debugRepository.dropTable();
  }
}
