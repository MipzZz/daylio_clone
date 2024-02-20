import 'package:daylio_clone/src/features/debug/presentation/view/debug_screen.dart';
import 'package:daylio_clone/src/features/main/presentation/view/main_screen.dart';
import 'package:daylio_clone/src/features/more/presentation/view/about_screen.dart';
import 'package:daylio_clone/src/features/notes/presentation/view/add_note_screen.dart';
import 'package:daylio_clone/src/features/notes/presentation/view/note_details_screen.dart';
import 'package:flutter/material.dart';

abstract class AppRouteNames {
  static const String root = '/';
  static const String debug = '/debug';
  static const String addNote = '/add_note';
  static const String noteDetails = '/note_details';
  static const String about = '/about';
}

class MainNavigator {
  final routes = <String, Widget Function(BuildContext)>{
    AppRouteNames.root: (context) => const MainScreen(),
    AppRouteNames.debug: (context) => const DebugScreen(),
    AppRouteNames.addNote: (context) => const AddNoteWidget(),
    AppRouteNames.about: (context) => const AboutScreen(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.noteDetails:
        final arguments = settings.arguments;
        // TODO(MipZ): Придумать как избавиться от присвоения 0, в случаях неккоректного типа аргумента аргументов
        final id = arguments is int
            ? arguments
            : 0;
        return MaterialPageRoute(
          builder: (context) => NoteDetailsWidget(noteId: id),
        );
      default:
        const widget = Text('Ошибка навигации');
        return MaterialPageRoute(builder: (_) => widget);
    }
  }
}
