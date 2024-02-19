import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class AppBlocObserver extends BlocObserver {
  factory AppBlocObserver.instance() => _singleton ??= AppBlocObserver._();

  AppBlocObserver._();
  static AppBlocObserver? _singleton;

  @override
  void onCreate(BlocBase<Object?> bloc) {
    super.onCreate(bloc);
    debugPrint('Create: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc<Object?, Object?> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (event == null) return;
    debugPrint('Event: ${bloc.runtimeType}.add(${event.runtimeType})');
    final state = bloc.state;
    if (state == null) return;
  }

  @override
  void onTransition(
    Bloc<Object?, Object?> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    final Object? event = transition.event;
    final Object? currentState = transition.currentState;
    final Object? nextState = transition.nextState;
    if (event == null || currentState == null || nextState == null) return;
    debugPrint(
      'Transition: ${bloc.runtimeType} ${event.runtimeType}: ${currentState.runtimeType}->${nextState.runtimeType}',
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint('BLOC OBSERVER: $error');
    debugPrintStack(stackTrace: stackTrace);
    // logger.d('BLOC OBSERVER: $error', stackTrace: stackTrace);
    // ErrorUtil.logError(
    //   error,
    //   stackTrace: stackTrace,
    //   hint: 'BLoC: ${bloc.runtimeType}',
    // );
  }

  @override
  void onClose(BlocBase<Object?> bloc) {
    super.onClose(bloc);
    debugPrint('Close: ${bloc.runtimeType}.close()');
  }
}
