import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:daylio_clone/src/core/domain/bloc/app_bloc_observer.dart';
import 'package:daylio_clone/src/features/app/presentation/view/app_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

/// метод доступа к запуску прилы
Future<void> run() async {
  _runApp();
}

void _runApp() {
  runZonedGuarded(() {
    /// здесь также может быть внедрение зависимостей,
    /// которые нужны во всем приложении
    /// Также здесь в будущем может быть SplashScreen, а также ErrorScreen
    /// если вдруг не проинициализировалось что-то критичное, без
    /// чего запуск приложения не имеет смысла

    Bloc.observer = AppBlocObserver.instance();
    Bloc.transformer = sequential<Object?>();
    initializeDateFormatting('ru_RU', null)
        .then((_) => runApp(const AppView()));
  }, (error, stack) {
    /// хотя бы базовый вывод ошибок, которые ты пропустишь, но
    /// не стоит им давать прорываться буквально насквозь.
    debugPrint('$error\n$stack');
  });
}
