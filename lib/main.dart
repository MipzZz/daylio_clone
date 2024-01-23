import 'package:daylio_clone/runner.dart';

Future<void> main() async {
  /// помимо main файла также могут быть
  /// main_qa main_release и тд
  /// ниже может быть инициализация окружения
  /// поэтому основной запуск мы будем делать
  /// в runner.dart

  await run();
}
