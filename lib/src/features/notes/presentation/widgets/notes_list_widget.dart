import 'package:collection/collection.dart';
import 'package:daylio_clone/src/core/presentation/assets/buttons/app_button_style.dart';
import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/core/presentation/assets/text/app_text_style.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_bloc/notes_bloc.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_bloc/notes_event.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_bloc/notes_state.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotesListWidget extends StatefulWidget {
  const NotesListWidget({super.key});

  @override
  State<NotesListWidget> createState() => _NotesListWidgetState();
}

class _NotesListWidgetState extends State<NotesListWidget> {
  @override
  Widget build(BuildContext context) => BlocBuilder<NotesBloc, NotesState>(
        builder: (BuildContext context, NotesState state) => switch (state) {
        NotesState$Progress() => const Center(
            child: CircularProgressIndicator(),
          ),
        final NotesState$Error errorState =>
          _FailureBody(errorMessage: errorState.message),
        _ => const _NotesListView(),
      },);
}

class _FailureBody extends StatelessWidget {
  const _FailureBody({
    required this.errorMessage,
  });

  final String errorMessage;

  void _refreshList(BuildContext context) {
    context.read<NotesBloc>().add(NotesEvent$Initialize());
  }

  @override
  Widget build(BuildContext context) => Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () => _refreshList(context),
            style: AppButtonStyle.addNoteButtonStyle,
            child: const Text('Обновить'),
          ),
        ],
      ),
    );
}

class _NotesListView extends StatefulWidget {
  const _NotesListView();

  @override
  State<_NotesListView> createState() => _NotesListViewState();
}

class _NotesListViewState extends State<_NotesListView> {
  final ScrollController _scrollController = ScrollController();

  void _onNoteTab(int? id) {
    if (id == null) return;
    Navigator.of(context).pushNamed(
      '/note_detail',
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<void> refreshList() async {
      context.read<NotesBloc>().add(NotesEvent$Refresh());
      await context.read<NotesBloc>().stream.firstWhere(
            (element) => switch (element) {
              NotesState$Data() => true,
              NotesState$Error() => true,
              _ => false
            },
          );
    }

    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeInOut,);
          }
        });
        final sortedNotes =
            state.notes.sorted((a, b) => a.date.compareTo(b.date));
        return RefreshIndicator(
          onRefresh: refreshList,
          child: ListView.builder(
            controller: _scrollController,
            shrinkWrap: true,
            reverse: true,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 5),
            itemCount: state.notes.length,
            itemBuilder: (BuildContext context, int index) {
              final note = sortedNotes[index];
              final borderRadius = BorderRadius.only(
                topLeft: index == state.notes.length - 1
                    ? const Radius.circular(20.0)
                    : Radius.zero,
                topRight: index == state.notes.length - 1
                    ? const Radius.circular(20.0)
                    : Radius.zero,
                bottomLeft:
                    index == 0 ? const Radius.circular(20.0) : Radius.zero,
                bottomRight:
                    index == 0 ? const Radius.circular(20.0) : Radius.zero,
              );
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  children: [
                    Ink(
                      child: InkWell(
                        borderRadius: borderRadius,
                        onTap: () => _onNoteTab(note.id),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.listBackground,
                            borderRadius: borderRadius,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  note.mood.selectedIcon,
                                  height: 50,
                                  width: 50,
                                ),
                                const SizedBox(width: 13),
                                //Расстояние между иконко и информацией
                                Expanded(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _MoodRow(note: note),
                                        _SleepAndFoodRow(note: note),
                                      ],),
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
          ),
        );
      },
    );
  }
}

class _MoodRow extends StatelessWidget {
  const _MoodRow({
    required NoteModel note,
  }) : _note = note;

  final NoteModel _note;

  @override
  Widget build(BuildContext context) => Row(
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

class _SleepAndFoodRow extends StatelessWidget {
  const _SleepAndFoodRow({
    required NoteModel note,
  }) : _note = note;

  final NoteModel _note;

  @override
  Widget build(BuildContext context) => Row(
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
