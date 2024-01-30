import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/features/notes_list/domain/entity/note_model.dart';
import 'package:daylio_clone/src/features/notes_list/domain/provider/notes_provider/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesWidget extends StatefulWidget {
  const NotesWidget({super.key});

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {

  void _onNoteTab(int index) {
    final id = index;
    Navigator.of(context).pushNamed(
      '/note_detail',
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _notes = context.select((NotesProvider vm) => vm.state.notes);
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 5),
          itemCount: _notes.length,
          itemExtent: 90,
          itemBuilder: (BuildContext context, int index) {
            final _note = _notes[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.listBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: index == 0
                            ? const Radius.circular(20.0)
                            : Radius.zero,
                        topRight: index == 0
                            ? const Radius.circular(20.0)
                            : Radius.zero,
                        bottomLeft: index == _notes.length - 1
                            ? const Radius.circular(20.0)
                            : Radius.zero,
                        bottomRight: index == _notes.length - 1
                            ? const Radius.circular(20.0)
                            : Radius.zero,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.face,
                              size: 70, color: AppColors.mainGreen),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _MoodRow(note: _note),
                              _SleepAndFoodRow(note: _note),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _onNoteTab(_note.id),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SleepAndFoodRow extends StatelessWidget {
  const _SleepAndFoodRow({
    super.key,
    required NoteModel note,
  }) : _note = note;

  final NoteModel _note;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.bed,
            color: AppColors.mainGreen),
        Text(_note.sleep),
        const SizedBox(width: 10),
        const Icon(Icons.emoji_food_beverage,
            color: AppColors.mainGreen),
        Text(_note.food),
      ],
    );
  }
}

class _MoodRow extends StatelessWidget {
  const _MoodRow({
    super.key,
    required NoteModel note,
  }) : _note = note;

  final NoteModel _note;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          _note.mood,
          maxLines: 1,
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(width: 10),
        Text('${_note.date.hour}:${_note.date.minute}',),
      ],
    );
  }
}
