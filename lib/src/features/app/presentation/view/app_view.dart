import 'package:daylio_clone/src/core/data/source/local/db/drift_storage.dart';
import 'package:daylio_clone/src/core/presentation/assets/themes/AppThemeData.dart';
import 'package:daylio_clone/src/features/notes_list/presentation/add_note_screen.dart';
import 'package:daylio_clone/src/features/main_screen/presentation/main_screen.dart';
import 'package:daylio_clone/src/features/notes_list/presentation/note_details_screen.dart';
import 'package:daylio_clone/src/features/notes_list/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes_list/domain/provider/notes_provider/notes_provider.dart';
import 'package:daylio_clone/src/features/statistic/data/statistic_repository.dart';
import 'package:daylio_clone/src/features/statistic/domain/provider/statistic_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppView extends StatefulWidget {
  AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late final AppDb _driftStorage;

  late final NotesRepository _notesRepository;
  late final StatisticRepository _statisticRepository;

  @override
  void initState() {
    super.initState();
    _driftStorage = AppDb();
    _notesRepository = NotesRepository(database: _driftStorage);
    _statisticRepository = StatisticRepository(database: _driftStorage);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NotesProvider(notesRepository: _notesRepository),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              StatisticProvider(statisticRepository: _statisticRepository),
        ),
        Provider(
          create: (context) => _notesRepository,
        ),
        Provider(
          create: (context) => _statisticRepository,
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
