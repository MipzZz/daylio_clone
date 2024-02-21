import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/core/utils/extensions/string_extension.dart';
import 'package:daylio_clone/src/features/more/presentation/view/more_screen.dart';
import 'package:daylio_clone/src/features/navigation/domain/app_routes.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_bloc/notes_bloc.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_bloc/notes_state.dart';
import 'package:daylio_clone/src/features/notes/presentation/widgets/notes_list_widget.dart';
import 'package:daylio_clone/src/features/statistic/presentation/view/statistic_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTab = 0;

  void _addDays(BuildContext context) {
    // context.read<MainBloc>().add(MainEvent$AddTime());
  }

  void _reduceDays(BuildContext context) {
    // context.read<MainBloc>().add(MainEvent$ReduceTime());
  }

  final List<Widget> _tabs = [
    const NotesListWidget(),
    const StatisticWidget(),
    const MoreWidget(),
  ];

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  Future<void> _addNote() async {
    await Navigator.pushNamed(context, AppRouteNames.addNote);
  }

  Future<void> _onDebug() async {
    await Navigator.pushNamed(context, AppRouteNames.debug);
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.bug_report),
              onPressed: _onDebug,
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 10),
            ],
            title: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ),
                    onPressed: () => _reduceDays(context),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Text(
                    DateFormat.yMMMM('ru-Ru')
                        .format(DateTime.now())
                        .capitalize(),
                  ),
                ),
                Flexible(
                  child: IconButton(
                    icon: const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                    onPressed: () => _addDays(context),
                  ),
                ),
              ],
            ),
            centerTitle: true,
          ),
          body: IndexedStack(
            index: _selectedTab,
            children: _tabs,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: _addNote,
            backgroundColor: AppColors.bottomNavigationBarBackground,
            shape: const CircleBorder(
              side: BorderSide(color: AppColors.background, width: 2.3),
            ),
            foregroundColor: Colors.black,
            elevation: 10,
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.symmetric(
              horizontal: 9.0,
              vertical: 0.0,
            ),
            height: 70.0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  // TODO(Mipz): Сделать более лаконично
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => onSelectTab(0),
                      icon: const Icon(Icons.notes),
                      color: _selectedTab == 0
                          ? AppColors.bottomNavigationBarSelectedItemColor
                          : AppColors.bottomNavigationBarUnselectedItemColor,
                    ),
                    FittedBox(
                      child: Text(
                        'Записи',
                        style: TextStyle(
                          fontSize: 12,
                          color: _selectedTab == 0
                              ? AppColors.bottomNavigationBarSelectedItemColor
                              : AppColors
                                  .bottomNavigationBarUnselectedItemColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => onSelectTab(1),
                      icon: const Icon(Icons.stacked_bar_chart),
                      color: _selectedTab == 1
                          ? AppColors.bottomNavigationBarSelectedItemColor
                          : AppColors.bottomNavigationBarUnselectedItemColor,
                    ),
                    FittedBox(
                      child: Text(
                        'Статистика',
                        style: TextStyle(
                          fontSize: 12,
                          color: _selectedTab == 1
                              ? AppColors.bottomNavigationBarSelectedItemColor
                              : AppColors
                                  .bottomNavigationBarUnselectedItemColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => onSelectTab(2),
                      icon: const Icon(Icons.more_horiz),
                      color: _selectedTab == 2
                          ? AppColors.bottomNavigationBarSelectedItemColor
                          : AppColors.bottomNavigationBarUnselectedItemColor,
                    ),
                    FittedBox(
                      child: Text(
                        'Более',
                        style: TextStyle(
                          fontSize: 12,
                          color: _selectedTab == 2
                              ? AppColors.bottomNavigationBarSelectedItemColor
                              : AppColors
                                  .bottomNavigationBarUnselectedItemColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 1),
              ],
            ),
          ),
        ),
      );
}
