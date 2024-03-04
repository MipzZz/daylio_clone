import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/core/utils/extensions/string_extension.dart';
import 'package:daylio_clone/src/features/main/presentation/widgets/bottom_bar_item.dart';
import 'package:daylio_clone/src/features/more/presentation/view/more_screen.dart';
import 'package:daylio_clone/src/features/navigation/domain/app_routes.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_bloc/notes_bloc.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_bloc/notes_event.dart';
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

  final List<Widget> _tabs = [
    const NotesListWidget(),
    const StatisticWidget(),
    const MoreWidget(),
  ];

  void _onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  Future<void> _onDebug() async {
    await Navigator.pushNamed(context, AppRouteNames.debug);
  }

  Future<void> _onSearch() async {
    await Navigator.pushNamed(context, AppRouteNames.search);
  }

  void _scrollToItem(GlobalObjectKey key) {
    final targetContext = key.currentContext;
    if (targetContext != null) {
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<NotesBloc, NotesState>(
        listener: (previous, current) => _scrollToItem(
          GlobalObjectKey(
            '${current.date.month}-${current.date.year}'.hashCode,
          ),
        ),
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
                onPressed: _onSearch,
              ),
              const SizedBox(width: 10),
            ],
            title: const _TitleMonth(),
            centerTitle: true,
          ),
          body: IndexedStack(
            index: _selectedTab,
            children: _tabs,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: const _AddButton(),
          bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.symmetric(
              horizontal: 9.0,
              vertical: 0.0,
            ),
            height: 70.0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: BottomBarItemWidget(
                    index: index,
                    onSelectTab: () => _onSelectTab(index),
                    isSelected: _selectedTab == index,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _TitleMonth extends StatelessWidget {
  const _TitleMonth();

  void _addDays(BuildContext context) {
    context.read<NotesBloc>().add(NotesEvent$AddTime());
  }

  void _reduceDays(BuildContext context) {
    context.read<NotesBloc>().add(NotesEvent$ReduceTime());
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) => switch (state) {
            NotesState$Initial() => const SizedBox.shrink(),
            NotesState$Progress() => const CircularProgressIndicator(),
            _ => Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        color: state.date
                                .copyWith(month: state.date.month)
                                .isBefore(
                                  state.sortedNotes.lastOrNull?.date ??
                                      DateTime.now(),
                                )
                            ? Colors.grey
                            : Colors.white,
                      ),
                      onPressed: state.date
                              .copyWith(month: state.date.month)
                              .isBefore(state.sortedNotes.lastOrNull?.date ??
                                  DateTime.now(),)
                          ? null
                          : () => _reduceDays(context),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: Text(
                        DateFormat.yMMMM('ru-Ru')
                            .format(state.date)
                            .capitalize(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        Icons.chevron_right,
                        color: state.date
                                .copyWith(month: state.date.month + 1)
                                .isAfter(DateTime.now())
                            ? Colors.grey
                            : Colors.white,
                      ),
                      onPressed: state.date
                              .copyWith(month: state.date.month + 1)
                              .isAfter(DateTime.now())
                          ? null
                          : () => _addDays(context),
                    ),
                  ),
                ],
              ),
          },);
}

class _AddButton extends StatelessWidget {
  const _AddButton();

  Future<void> _addNote(BuildContext context) async {
    await Navigator.pushNamed(context, AppRouteNames.addNote);
  }

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        onPressed: () => _addNote(context),
        backgroundColor: AppColors.bottomNavigationBarBackground,
        shape: const CircleBorder(
          side: BorderSide(color: AppColors.background, width: 2.3),
        ),
        foregroundColor: Colors.black,
        elevation: 10,
        child: const Icon(Icons.add),
      );
}
