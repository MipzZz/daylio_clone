import 'package:daylio_clone/src/themes/app_colors.dart';
import 'package:daylio_clone/src/widgets/notes/notes_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;

  final List<Widget> _tabs = [
    const NotesWidget(),
    const Text('Статистика'),
    const Text('Более'),
  ];

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat.yMMMM().format(DateTime.now())),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: _tabs,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.bottomNavigationBarBackground,
        shape: const CircleBorder(
          side: BorderSide(color: AppColors.background, width: 2.3),
        ),
        foregroundColor: Colors.black,
        elevation: 10,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    onSelectTab(0);
                  },
                  icon: const Icon(Icons.notes),
                  color: _selectedTab == 0 ? Colors.black : AppColors.listBackground,
                ),
                const Text('Записи', style: TextStyle(fontSize: 5),),
              ],
            ),


            Column(
              children: [
                IconButton(
                  onPressed: () {
                    onSelectTab(1);
                  },
                  icon: const Icon(Icons.stacked_bar_chart),
                  color: _selectedTab == 1 ? Colors.black : AppColors.listBackground,
                ),
                const Text('Статистика', style: TextStyle(fontSize: 5),),
              ],

            ),


            Column(
              children: [
                IconButton(
                  onPressed: () {
                    onSelectTab(2);
                  },
                  icon: const Icon(Icons.more_horiz),
                  color: _selectedTab == 2 ? Colors.black : AppColors.listBackground,
                ),
                const Text('Более', style: TextStyle(fontSize: 5),),
              ],
            ),


            const SizedBox(width: 5),

          ],
        ),

        // currentIndex: _selectedTab,
        // items: const [
        //   BottomNavigationBarItem(
        //     icon:  Icon(Icons.notes),
        //     label: 'Записи',
        //   ),
        //   BottomNavigationBarItem(
        //     icon:  Icon(Icons.stacked_bar_chart),
        //     label: 'Статистика',
        //   ),
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.more_horiz),
        //     label: 'Более',
        //   ),
        //],
      ),
    );
  }
}
