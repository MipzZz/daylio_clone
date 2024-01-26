import 'package:daylio_clone/src/features/sample_feature/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/sample_feature/domain/provider/notes_provider/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sample extends StatelessWidget {
  const Sample({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotesProvider(
        notesRepository: context.read<NotesRepository>(),
      ),
      child: const Scaffold(),
    );
  }
}
