import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:daylio_clone/src/features/debug/data/debug_repository.dart';

part 'debug_event.dart';

part 'debug_state.dart';

class DebugBloc extends Bloc<DebugEvent, DebugState> {
  DebugBloc({required DebugRepository debugRepository})
      : _debugRepository = debugRepository,
        super(DebugInitial()) {
    on<DebugEvent>(
      (event, emitter) => switch (event) {
        final DebugEvent$DropTable event => _dropTable(event, emitter),
      },
    );
  }

  final DebugRepository _debugRepository;

  Future<void> _dropTable(
    DebugEvent$DropTable event,
    Emitter<DebugState> emitter,
  ) async {
    await _debugRepository.dropTable();
  }
}
