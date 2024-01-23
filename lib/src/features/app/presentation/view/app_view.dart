import 'package:daylio_clone/src/themes/app_colors.dart';
import 'package:daylio_clone/src/widgets/main_screen/main_screen_widget.dart';
import 'package:flutter/material.dart';

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
      home: const MainScreenWidget(),
    );
  }
}
