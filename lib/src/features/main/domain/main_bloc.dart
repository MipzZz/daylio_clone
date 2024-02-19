
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/cupertino.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState$Data(date: DateTime.now())) {
    on<MainEvent>((event, emitter) =>
    switch(event){
      final MainEvent$AddTime event => _addTime(event, emitter),
      final MainEvent$ReduceTime event => _reduceTime(event, emitter)
    },
      transformer: sequential(),
    );
  }

  void _addTime(MainEvent$AddTime event,
      Emitter<MainState> emitter,) {
      state.copyWith(date: state.date.copyWith(month: state.date.month + 1));
  }

  void _reduceTime(MainEvent$ReduceTime event,
      Emitter<MainState> emitter,) {
    state.copyWith(date: state.date.copyWith(month: state.date.month - 1));
  }
}
