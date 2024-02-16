import 'package:daylio_clone/src/core/data/source/local/db/drift_storage.dart';
import 'package:daylio_clone/src/core/presentation/assets/themes/app_theme_data.dart';
import 'package:daylio_clone/src/features/debug/data/debug_repository.dart';
import 'package:daylio_clone/src/features/debug/presentation/view/debug_screen.dart';
import 'package:daylio_clone/src/features/main/presentation/view/main_screen.dart';
import 'package:daylio_clone/src/features/more/presentation/view/about_screen.dart';
import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_bloc/notes_bloc.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_bloc/notes_event.dart';
import 'package:daylio_clone/src/features/notes/presentation/view/add_note_screen.dart';
import 'package:daylio_clone/src/features/notes/presentation/view/note_details_screen.dart';
import 'package:daylio_clone/src/features/statistic/domain/bloc/statistic_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late final AppDb _driftStorage;
  late final NotesRepository _notesRepository;
  late final DebugRepository _debugRepository;

  @override
  void initState() {
    super.initState();
    _driftStorage = AppDb();
    _notesRepository = NotesRepository(database: _driftStorage);
    _debugRepository = DebugRepository(database: _driftStorage);
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider(
            create: (context) => _notesRepository,
          ),
          Provider(
            create: (context) => _debugRepository,
          ),
          BlocProvider(
            create: (context) => NotesBloc(notesRepository: _notesRepository)
              ..add(NotesEvent$Read()),
          ),
          BlocProvider(
            create: (context) =>
                StatisticBloc(notesRepository: _notesRepository)
                  ..add(StatisticEvent$Initialize()),
          ),
        ],
        child: MaterialApp(
          theme: AppThemeData.darkMainTheme,
          title: 'Daylio Clone',
          routes: {
            '/': (context) => const MainScreen(),
            '/debug': (context) => const DebugScreen(),
            '/note_detail': (context) {
              final arguments = ModalRoute.of(context)?.settings.arguments;
              if (arguments is int) {
                return NoteDetailsWidget(noteId: arguments);
              } else {
                return const NoteDetailsWidget(noteId: 1);
              }
            },
            '/add_note': (context) => const AddNoteWidget(),
            '/about': (context) => const AboutScreen(),
          },
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(
                child: Text('Произошла ошибка навигации'),
              ),
            ),
          ),
        ),
      );
}
