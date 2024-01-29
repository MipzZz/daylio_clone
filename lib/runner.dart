import 'dart:async';
import 'package:daylio_clone/src/features/app/presentation/view/app_view.dart';
import 'package:flutter/cupertino.dart';

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

    runApp(AppView());
  }, (error, stack) {
    /// хотя бы базовый вывод ошибок, которые ты пропустишь, но
    /// не стоит им давать прорываться буквально насквозь.
    debugPrint('$error\n$stack');
  });
}
