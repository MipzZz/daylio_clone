import 'package:daylio_clone/src/features/debug/data/debug_repository.dart';

class DebugProvider{
  final DebugRepository _debugRepository;

  DebugProvider({required DebugRepository debugRepository}): _debugRepository = debugRepository;

  void dropTables(){
    // _debugRepository.dropTables();
  }
}