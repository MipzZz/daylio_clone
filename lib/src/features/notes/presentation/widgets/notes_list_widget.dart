import 'package:daylio_clone/src/core/presentation/assets/buttons/app_button_style.dart';
import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/core/presentation/assets/text/app_text_style.dart';
import 'package:daylio_clone/src/core/utils/extensions/date_time_extension.dart';
import 'package:daylio_clone/src/features/navigation/domain/app_routes.dart';
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
        },
      );
}

class _FailureBody extends StatelessWidget {
  const _FailureBody({
    required this.errorMessage,
  });

  final String errorMessage;

  void _readNotes(BuildContext context) {
    context.read<NotesBloc>().add(NotesEvent$Read());
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
              onPressed: () => _readNotes(context),
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

  Future<void> _refreshList() async {
    context.read<NotesBloc>().add(NotesEvent$Refresh());
    await context.read<NotesBloc>().stream.firstWhere(
          (element) => switch (element) {
            NotesState$Data() => true,
            NotesState$Error() => true,
            _ => false
          },
        );
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<NotesBloc, NotesState>(
        listenWhen: (previous, current) =>
            previous.notes.length < current.notes.length,
        listener: (_, __) =>
            SchedulerBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
            );
          }
        }),
        builder: (context, state) => RefreshIndicator(
          onRefresh: _refreshList,
          child: Padding(
            padding: const EdgeInsets.only(top: 5, right: 16, left: 16),
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              itemCount: state.notes.length,
              itemBuilder: (BuildContext context, int index) => ListViewItem(
                notes: state.sortedNotes,
                index: index,
              ),
            ),
          ),
        ),
      );
}

class ListViewItem extends StatelessWidget {
  const ListViewItem({
    super.key,
    required this.notes,
    required this.index,
  });

  final List<NoteModel> notes;
  final int index;

  void _onNoteTab(BuildContext context, int? id) {
    if (id == null) return;
    Navigator.pushNamed(context, AppRouteNames.noteDetails, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    final note = notes[index];
    final borderRadius = BorderRadius.only(
      bottomLeft: index == 0 ? const Radius.circular(20.0) : Radius.zero,
      bottomRight: index == 0 ? const Radius.circular(20.0) : Radius.zero,
      topLeft:
          index == notes.length - 1 ? const Radius.circular(20.0) : Radius.zero,
      topRight:
          index == notes.length - 1 ? const Radius.circular(20.0) : Radius.zero,
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.mainGreen,
        borderRadius: borderRadius,
      ),
      // TODO(MipZ): Обрезать сплеш по айтему, при скроле
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () => _onNoteTab(context, note.id),
        child: Padding(
          padding: const EdgeInsets.all(8.5),
          child: Row(
            children: [
              SvgPicture.asset(
                note.mood.selectedIcon,
                height: 50,
                width: 50,
              ),
              const SizedBox(width: 13),
              //Расстояние между иконкой и информацией
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
          Text(_note.date.toTimeOnly()),
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
