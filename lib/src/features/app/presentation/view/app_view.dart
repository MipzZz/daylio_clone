import 'package:daylio_clone/src/core/data/source/local/db/drift_storage.dart';
import 'package:daylio_clone/src/core/presentation/assets/themes/app_theme_data.dart';
import 'package:daylio_clone/src/features/debug/data/debug_repository.dart';
import 'package:daylio_clone/src/features/main/domain/main_bloc.dart';
import 'package:daylio_clone/src/features/navigation/domain/app_routes.dart';
import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_bloc/notes_bloc.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_bloc/notes_event.dart';
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
  final mainNavigator = MainNavigator();

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
          BlocProvider(
            create: (context) => MainBloc(),
          ),
        ],
        child: MaterialApp(
          theme: AppThemeData.darkMainTheme,
          title: 'Daylio Clone',
          routes: mainNavigator.routes,
          initialRoute: AppRouteNames.root,
          onGenerateRoute: mainNavigator.onGenerateRoute,
        ),
      );
}
