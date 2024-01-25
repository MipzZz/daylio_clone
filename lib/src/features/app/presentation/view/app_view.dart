import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../sample_feature/presentation/add_note/add_note_screen.dart';
import '../../../sample_feature/presentation/main_screen/main_screen.dart';
import '../../../sample_feature/presentation/notes_details/note_details_screen.dart';


class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: AppColors.background,
          rangePickerHeaderForegroundColor: AppColors.mainTextColor,
          weekdayStyle: TextStyle(color: AppColors.mainTextColor),
          headerForegroundColor: AppColors.mainTextColor,
          dayForegroundColor: MaterialStatePropertyAll(AppColors.mainTextColor),
          yearForegroundColor: MaterialStatePropertyAll(AppColors.mainTextColor),
          todayForegroundColor: MaterialStatePropertyAll(AppColors.mainTextColor),
        ),
        timePickerTheme: const TimePickerThemeData(
          backgroundColor: AppColors.background,
        ),
        appBarTheme: const AppBarTheme(
          foregroundColor: AppColors.mainTextColor,
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
