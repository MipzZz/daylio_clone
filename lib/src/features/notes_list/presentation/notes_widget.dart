import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/core/presentation/assets/res/app_icons.dart';
import 'package:daylio_clone/src/core/presentation/assets/text/app_text_style.dart';
import 'package:daylio_clone/src/features/notes_list/domain/entity/note_model.dart';
import 'package:daylio_clone/src/features/notes_list/domain/provider/notes_provider/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final notes = context.select((NotesProvider vm) => vm.state.notes);
    return ListView.builder(
      padding: const EdgeInsets.only(top: 5),
      itemCount: notes.length,
      itemBuilder: (BuildContext context, int index) {
        final note = notes[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            children: [
              Ink(
                child: InkWell(
                  onTap: () => _onNoteTab(note.id),
                  child: Container(
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
                        bottomLeft: index == notes.length - 1
                            ? const Radius.circular(20.0)
                            : Radius.zero,
                        bottomRight: index == notes.length - 1
                            ? const Radius.circular(20.0)
                            : Radius.zero,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            note.mood.icon['selected'] ?? AppIcons.badRegular,
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _MoodRow(note: note),
                                _SleepAndFoodRow(note: note),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 7,
            leading: Icon(Icons.bed, color: _note.sleep.color),
            title: Text(
              _note.sleep.title,
              style: AppTextStyle.noteListItemSub,
            ),
          ),
        ),
        const SizedBox(width: 5),
        Flexible(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 7,
            dense: true,
            leading: Icon(Icons.emoji_food_beverage, color: _note.food.color),
            title: Text(
              _note.food.title,
              style: AppTextStyle.noteListItemSub,
            ),
          ),
        ),
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
          _note.mood.title,
          maxLines: 1,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 20, color: _note.mood.color),
        ),
        const SizedBox(width: 10),
        Text(
          '${_note.date.hour}:${_note.date.minute}',
        ),
      ],
    );
  }
}
