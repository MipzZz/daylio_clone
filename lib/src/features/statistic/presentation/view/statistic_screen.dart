import 'package:daylio_clone/src/core/presentation/assets/buttons/app_button_style.dart';
import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/core/presentation/assets/text/app_text_style.dart';
import 'package:daylio_clone/src/features/statistic/domain/bloc/statistic_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticWidget extends StatelessWidget {
  const StatisticWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<StatisticBloc, StatisticState>(
        builder: (context, statisticState) => switch (statisticState) {
          StatisticState$Progress() => const Center(
              child: CircularProgressIndicator(),
            ),
          final StatisticState$Error errorState =>
            _FailureBody(errorMessage: errorState.message),
          _ => (statisticState.notesCount) > 2
              ? const _DefaultBodyWidget()
              : const _NotEnoughNotesWidget()
        },
      );
}

class _FailureBody extends StatelessWidget {
  const _FailureBody({
    required this.errorMessage,
  });

  final String errorMessage;

  void _refreshList(BuildContext context) {
    context.read<StatisticBloc>().add(StatisticEvent$Initialize());
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

class _NotEnoughNotesWidget extends StatelessWidget {
  const _NotEnoughNotesWidget();

  @override
  Widget build(BuildContext context) => const Center(
        child: Text(
          'Для отображение статистики, необходимо минимум 3 записи',
          textAlign: TextAlign.center,
        ),
      );
}

class _DefaultBodyWidget extends StatelessWidget {
  const _DefaultBodyWidget();

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: _NotesCountCard()),
                Flexible(child: _AverageMoodCard()),
                Flexible(child: _ActivityCountCard()),
              ],
            ),
          ],
        ),
      );
}

class _NotesCountCard extends StatelessWidget {
  const _NotesCountCard();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<StatisticBloc, StatisticState>(
        builder: (context, statisticState) => Card(
          color: AppColors.listBackground,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statisticState.notesCount.toString(),
                  style: AppTextStyle.statisticText,
                ),
                const ListTile(
                  leading: Icon(
                    Icons.sticky_note_2_rounded,
                    color: Colors.blueAccent,
                  ),
                  title: Text(
                    'Записи',
                    style: TextStyle(color: Colors.white),
                  ),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 7,
                ),
              ],
            ),
          ),
        ),
      );
}

class _AverageMoodCard extends StatelessWidget {
  const _AverageMoodCard();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<StatisticBloc, StatisticState>(
        builder: (context, statisticState) => Card(
          color: AppColors.listBackground,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  statisticState.averageMood.toStringAsFixed(1),
                  style: AppTextStyle.statisticText,
                ),
                const ListTile(
                  leading: Icon(
                    Icons.emoji_emotions,
                    color: Colors.amberAccent,
                  ),
                  title: Text(
                    'Муд',
                    style: TextStyle(color: Colors.white),
                  ),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 7,
                ),
              ],
            ),
          ),
        ),
      );
}

class _ActivityCountCard extends StatelessWidget {
  const _ActivityCountCard();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<StatisticBloc, StatisticState>(
        builder: (context, statisticState) => Card(
          color: AppColors.listBackground,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  statisticState.activityCount.toString(),
                  style: AppTextStyle.statisticText,
                ),
                const ListTile(
                  leading: Icon(
                    Icons.accessibility_new,
                    color: Colors.amberAccent,
                  ),
                  title: Text(
                    'Занятия',
                    style: TextStyle(color: Colors.white),
                  ),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 7,
                ),
              ],
            ),
          ),
        ),
      );
}
