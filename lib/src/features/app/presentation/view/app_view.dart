import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/widgets/main_screen/main_screen_widget.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/add_note/add_note_widget.dart';
import '../../../../widgets/notes_details/note_details_widget.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          titleTextStyle:
              TextStyle(color: AppColors.mainTextColor, fontSize: 20),
        ),
        scaffoldBackgroundColor: AppColors.background,
        bottomAppBarTheme: const BottomAppBarTheme(
          color: AppColors.bottomNavigationBarBackground,
          // selectedItemColor: Colors.black
        ),
        textTheme: Typography.whiteRedmond,
      ),
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
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text('Произошла ошибка навигации'),
            ),
          );
        });
      },

    );
  }
}
