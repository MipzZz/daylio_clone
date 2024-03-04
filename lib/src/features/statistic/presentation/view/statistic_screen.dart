import 'package:daylio_clone/src/core/presentation/assets/buttons/app_button_style.dart';
import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/core/presentation/assets/text/app_text_style.dart';
import 'package:daylio_clone/src/core/utils/extensions/date_time_extension.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/moods_storage.dart';
import 'package:daylio_clone/src/features/statistic/domain/bloc/statistic_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
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
          _ => (statisticState.notes.length) > 2
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
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
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
            Flexible(child: _DatePickerWidget()),
            Flexible(flex: 2, child: _PieChart()),
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
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {},
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
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {},
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
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {},
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
                      style: TextStyle(color: AppColors.mainTextColor),
                    ),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 7,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _DatePickerWidget extends StatefulWidget {
  const _DatePickerWidget();

  @override
  State<_DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<_DatePickerWidget> {
  Future<void> pickDateRange(BuildContext context) async {
    final DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
      saveText: 'Выбрать',
    );
    if (newDateRange == null) return;
    _saveTimeRange(newDateRange);
  }

  void _saveTimeRange(DateTimeRange newDateRange) {
    context
        .read<StatisticBloc>()
        .add(StatisticEvent$DateRangeChange(newDateRange));
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<StatisticBloc, StatisticState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  '${state.dateRange.start.dateOnly()} - '
                      '${state.dateRange.end.dateOnly()}',
                  style: AppTextStyle.rangeText,
                ),
              ),
              OutlinedButton(
                style: AppButtonStyle.buttonDateTimeStyle,
                onPressed: () => pickDateRange(context),
                child: const Text(
                  'Выберите период',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      );
}

class _PieChart extends StatelessWidget {
  const _PieChart();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<StatisticBloc, StatisticState>(
        builder: (context, state) => PieChart(
          PieChartData(
            sections: List.generate(
              5,
              (index) => PieChartSectionData(
                titleStyle: AppTextStyle.pieChart,
                title: state.moodsCount[MoodsStorage.values[index].title]
                    ?.toStringAsFixed(0),
                color: MoodsStorage.values[index].color,
                value: state.moodsCount[MoodsStorage.values[index].title] ?? 0,
              ),
            ),
          ),
        ),
      );
}
