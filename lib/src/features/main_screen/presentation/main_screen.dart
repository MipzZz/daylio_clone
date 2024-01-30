import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/features/more/presentation/more_widget.dart';
import 'package:daylio_clone/src/features/notes_list/presentation/notes_widget.dart';
import 'package:daylio_clone/src/features/sample_feature/domain/provider/notes_provider/notes_provider.dart';
import 'package:daylio_clone/src/features/statistic/presentation/statistic_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;

  final List<Widget> _tabs = [
    const NotesWidget(),
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
    final res = await Navigator.pushNamed(context, '/add_note');
    if (res == true && mounted) {
      context.read<NotesProvider>().readNotes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              width: 20,
            ),
            IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            Text(DateFormat.yMMMM().format(DateTime.now())),
            IconButton(
              icon: const Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
              onPressed: () {},
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
        padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 0.0),
        height: 70.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    onSelectTab(0);
                  },
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
                          : AppColors.bottomNavigationBarUnselectedItemColor,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    onSelectTab(1);
                  },
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
                          : AppColors.bottomNavigationBarUnselectedItemColor,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    onSelectTab(2);
                  },
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
                          : AppColors.bottomNavigationBarUnselectedItemColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 1),
          ],
        ),
      ),
    );
  }
}
