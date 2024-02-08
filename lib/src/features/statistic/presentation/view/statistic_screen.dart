import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/core/presentation/assets/text/app_text_style.dart';
import 'package:daylio_clone/src/features/notes/presentation/widgets/alert_failure_dialog_widget.dart';
import 'package:daylio_clone/src/features/statistic/domain/provider/statistic_provider.dart';
import 'package:daylio_clone/src/features/statistic/domain/provider/statistic_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticWidget extends StatelessWidget {
  const StatisticWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SwitchWidget();
  }
}

class _SwitchWidget extends StatelessWidget {
  const _SwitchWidget();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StatisticProvider>();

    return switch (viewModel.state) {
      StatisticStateInitial() => const Text('Инициализация'),
      StatisticStateError() => AlertFailureDialogWidget(
          message: (viewModel.state as StatisticStateError).message),
      StatisticStateData() => (viewModel.state.notesCount ?? 0) > 2
          ? const _DefaultBodyWidget()
          : const _NotEnoughNotesWidget()
    };
  }
}

class _NotEnoughNotesWidget extends StatelessWidget {
  const _NotEnoughNotesWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Для отображение статистики, необходимо минимум 3 записи'),
    );
  }
}

class _DefaultBodyWidget extends StatelessWidget {
  const _DefaultBodyWidget();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(flex: 1, child: _NotesCountCard()),
          // SizedBox(width: 35),
          Flexible(flex: 1, child: _AverageMoodCard()),
          Flexible(flex: 1, child: _ActivityCountCard()),
        ],
      ),
    );
  }
}

class _NotesCountCard extends StatelessWidget {
  const _NotesCountCard();

  @override
  Widget build(BuildContext context) {
    final statisticVM = context.watch<StatisticProvider>();
    return Card(
      color: AppColors.listBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              statisticVM.state.notesCount.toString(),
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
            )
          ],
        ),
      ),
    );
  }
}

class _AverageMoodCard extends StatelessWidget {
  const _AverageMoodCard();

  @override
  Widget build(BuildContext context) {
    final statisticVM = context.watch<StatisticProvider>();
    return Card(
      color: AppColors.listBackground,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              statisticVM.state.averageMood?.toStringAsFixed(1) ?? '0.0',
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
            )
          ],
        ),
      ),
    );
  }
}

class _ActivityCountCard extends StatelessWidget {
  const _ActivityCountCard();

  @override
  Widget build(BuildContext context) {
    final statisticVM = context.watch<StatisticProvider>();
    return Card(
      color: AppColors.listBackground,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              statisticVM.state.activityCount?.toString() ?? '0',
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
            )
          ],
        ),
      ),
    );
  }
}
