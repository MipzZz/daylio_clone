import 'package:daylio_clone/src/features/debug/data/debug_repository.dart';
import 'package:daylio_clone/src/features/debug/domain/bloc/debug_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebugScreen extends StatefulWidget {
  const DebugScreen({super.key});

  @override
  State<DebugScreen> createState() => _DebugScreenState();
}

class _DebugScreenState extends State<DebugScreen> {
  late final DebugBloc _debugBloc;

  @override
  void initState() {
    _debugBloc = DebugBloc(debugRepository: context.read<DebugRepository>());

    super.initState();
  }



  @override
  Widget build(BuildContext context) =>
      BlocProvider(
        create: (context) => _debugBloc,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Debug'),
          ),
          body: const _BodyWidget(),
        ),
      );
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget();

  void dropTables(BuildContext context) {
    context.read<DebugBloc>().add(DebugEvent$DropTable());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<DebugBloc, DebugState>(
      builder: (context, state) => Center(
        child: ElevatedButton(
            onPressed: () => dropTables(context),
            child: const Text('Drop table (need to hot restart)'),
          ),
      ),
    );
}
