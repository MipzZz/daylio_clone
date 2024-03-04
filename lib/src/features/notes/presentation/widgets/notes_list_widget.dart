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

  String _getDatAddition(int days) {
    final double preLastDigit = days % 100 / 10;
    if (preLastDigit == 1) {
      return 'Пропущено $days дней';
    }
    switch (days % 10) {
      case 1:
        return 'Пропущен $days день';
      case 2:
      case 3:
      case 4:
        return 'Пропущено $days дня';
      default:
        return 'Пропущено $days дней';
    }
  }

  void _dismissNote(int? id) {
    context.read<NotesBloc>().add(NotesEvent$Delete(id));
  }

  Iterable<Widget> _listWithTitle(Map<DateTime, List<NoteModel>> notes) sync* {
    for (int i = 0; i < notes.length; i++) {
      final entry = notes.entries.elementAt(i);
      //Берем месяц + год записи в строке и формируем из них int ключ
      GlobalObjectKey? keyMonth =
          GlobalObjectKey('${entry.key.month}-${entry.key.year}'.hashCode);
      // Если это не первая и не единственная запись в месяце
      if (notes.length > 1 && i > 0) {
        final prevEntry = notes.entries.elementAt(i - 1);
        final currentDate = entry.value[0].date;
        final previousDate = prevEntry.value.last.date;
        // Записи сортированы от самой новой до самой старой
        // Если месяцы прошлой и нынешней записи совпадают, то ключ обнуляется
        // и следующей по списку записи не присваивается ключ
        // Так как ключ должен быть только у ПЕРВОЙ записи в месяце
        if (entry.key.month == prevEntry.key.month) {
          keyMonth = null;
        }
        final difference = previousDate.difference(currentDate).inDays;
        if (difference > 1) {
          yield SliverPadding(
            padding: const EdgeInsets.only(bottom: 15),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: Text(
                  _getDatAddition(difference),
                  style: AppTextStyle.missedDaysText,
                ),
              ),
            ),
          );
        }
      }

      //Шапка день недели, число, месяц
      yield SliverToBoxAdapter(
        child: DecoratedBox(
          key: keyMonth,
          decoration: const BoxDecoration(
            color: AppColors.headerNoteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.5),
              child: Text(
                entry.key.toHeaderDate(),
                style: AppTextStyle.dateHeader,
              ),
            ),
          ),
        ),
      );
      yield SliverPadding(
        padding: const EdgeInsets.only(bottom: 15),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: entry.value.length,
            (BuildContext context, int index) => Dismissible(
              direction: DismissDirection.endToStart,
              background: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    bottomLeft: index == entry.value.length - 1
                        ? const Radius.circular(20.0)
                        : Radius.zero,
                    bottomRight: index == entry.value.length - 1
                        ? const Radius.circular(20.0)
                        : Radius.zero,
                  ),
                ),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (_) => _dismissNote(entry.value[index].id),
              key: ValueKey(entry.value[index].id),
              child: SliverListItem(
                notes: entry.value,
                index: index,
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<NotesBloc, NotesState>(
        // TODO(MipZ): Сделать скролл, к только что добавленной записи
        listenWhen: (previous, current) =>
            previous.notes.length < current.notes.length,
        listener: (_, __) => SchedulerBinding.instance.addPostFrameCallback(
          (_) {
            if (_scrollController.hasClients) {
              _scrollController.animateTo(
                _scrollController.position.extentInside,
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeInOut,
              );
            }
          },
        ),
        builder: (context, state) => RefreshIndicator(
          onRefresh: _refreshList,
          child: Padding(
            padding: const EdgeInsets.only(top: 5, right: 16, left: 16),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: _listWithTitle(state.groupedNotes).toList(),
            ),
          ),
        ),
      );
}

class SliverListItem extends StatelessWidget {
  const SliverListItem({
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
      bottomLeft:
          index == notes.length - 1 ? const Radius.circular(20.0) : Radius.zero,
      bottomRight:
          index == notes.length - 1 ? const Radius.circular(20.0) : Radius.zero,
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.listBackground,
        borderRadius: borderRadius,
      ),
      child: Material(
        color: Colors.transparent,
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

  // TODO(MipZ): Переделать ListTile в Icon + Text
  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ActivityWidget(
            icon: Icon(
              Icons.bed,
              color: _note.sleep.color,
            ),
            text: _note.sleep.title,
          ),
          _ActivityWidget(
            icon: Icon(
              Icons.emoji_food_beverage,
              color: _note.food.color,
            ),
            text: _note.food.title,
          ),
        ],
      );
}

class _ActivityWidget extends StatelessWidget {
  const _ActivityWidget({required this.icon, required this.text});

  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) => Flexible(
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 7,
          dense: true,
          leading: icon,
          title: Text(
            text,
            style: AppTextStyle.noteListItemSub,
          ),
        ),
      );
}
