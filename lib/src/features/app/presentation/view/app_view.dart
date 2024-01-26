import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/core/presentation/assets/themes/AppThemeData.dart';
import 'package:flutter/material.dart';

import '../../../add_note/presentation/add_note_screen.dart';
import '../../../main_screen/presentation/main_screen.dart';
import '../../../note_details/presentation/note_details_screen.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeData.darkMainTheme,
      title: 'Daylio Clone',
      // home: const MainScreenWidget(),
      routes: {
        '/': (context) => const MainScreenWidget(),
        '/note_detail': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments is int) {
            return NoteDetailsWidget(noteId: arguments);
          } else {
            return const NoteDetailsWidget(noteId: 1);
          }
        },
        '/add_note': (context) => const AddNoteWidget(),
      },
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(
                child: Text('Произошла ошибка навигации'),
              ),
            );
          },
        );
      },
    );
  }
}
