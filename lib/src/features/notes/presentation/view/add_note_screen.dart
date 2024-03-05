import 'package:daylio_clone/src/core/presentation/assets/buttons/app_button_style.dart';
import 'package:daylio_clone/src/core/presentation/assets/text/app_text_style.dart';
import 'package:daylio_clone/src/core/utils/extensions/date_time_extension.dart';
import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/add_note_bloc/add_note_bloc.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/add_note_bloc/add_note_event.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/add_note_bloc/add_note_state.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/grade_label.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/moods_storage.dart';
import 'package:daylio_clone/src/features/notes/presentation/widgets/alert_failure_dialog_widget.dart';
import 'package:daylio_clone/src/features/notes/presentation/widgets/build_blur.dart';
import 'package:daylio_clone/src/features/notes/presentation/widgets/mood_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNoteWidget extends StatefulWidget {
  const AddNoteWidget({super.key});

  @override
  State<AddNoteWidget> createState() => _AddNoteWidgetState();
}

class _AddNoteWidgetState extends State<AddNoteWidget> {
  late final AddNoteBloc _addNoteBloc;

  @override
  void initState() {
    _addNoteBloc =
        AddNoteBloc(notesRepository: context.read<NotesRepository>());
    _addNoteBloc.add(AddNoteEvent$Initialize(DateTime.now()));
    super.initState();
  }

  void _addNoteListener(BuildContext context, AddNoteState state) {
    switch (state) {
      case AddNoteState$Created():
        Navigator.of(context).pop();
      case final AddNoteState$Error errorState:
        showDialog<AlertFailureDialogWidget>(
          context: context,
          builder: (_) => AlertFailureDialogWidget(
            message: errorState.message,
          ),
        );
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => _addNoteBloc,
        child: BlocConsumer<AddNoteBloc, AddNoteState>(
          listener: _addNoteListener,
          builder: (context, addNoteState) => switch (addNoteState) {
            AddNoteState$Progress() => Stack(
                children: [
                  PopScope(
                    canPop: false, //Можно ли свай пнуть для возврата
                    child: AbsorbPointer(
                      absorbing: true, //Состояние обжора нажатий
                      child: buildBlur(
                        isLoading: true, //Состояние аллюра
                        child: const _BodyWidget(),
                      ),
                    ),
                  ),
                  const Positioned(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            _ => const _BodyWidget(),
          },
        ),
      );
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget();

  void _unFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Новая запись'),
        ),
        body: GestureDetector(
          onTap: () => _unFocus(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 50,
            ),
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: const [
                _DateNTimeRow(),
                SizedBox(height: 30),
                _MoodFacesRow(),
                SizedBox(height: 30),
                _SleepRowWidget(),
                SizedBox(height: 50),
                _FoodRowWidget(),
                SizedBox(height: 35),
                _AddNoteButton(),
              ],
            ),
          ),
        ),
      );
}

class _DateNTimeRow extends StatelessWidget {
  const _DateNTimeRow();

  @override
  Widget build(BuildContext context) => const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: _DatePickerWidget()),
          Expanded(child: _TimePickerWidget()),
        ],
      );
}

class _DatePickerWidget extends StatefulWidget {
  const _DatePickerWidget();

  @override
  State<_DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<_DatePickerWidget> {
  void _saveDate(DateTime date) {
    context.read<AddNoteBloc>().add(AddNoteEvent$DateChange(date));
  }

  Future<void> selectDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: context.read<AddNoteBloc>().state.date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (date == null) return;
    _saveDate(date);
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<AddNoteBloc, AddNoteState>(
        builder: (context, state) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              state.date.dateOnly(),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              style: AppButtonStyle.buttonDateTimeStyle,
              onPressed: selectDate,
              child: const Text(
                'Выбрать дату',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      );
}

class _TimePickerWidget extends StatefulWidget {
  const _TimePickerWidget();

  @override
  State<_TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<_TimePickerWidget> {
  TimeOfDay selectedTime = TimeOfDay.now();

  void _saveTime(TimeOfDay timeOfDay) {
    context.read<AddNoteBloc>().add(AddNoteEvent$TimeChange(timeOfDay));
  }

  Future<void> setTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: context.read<AddNoteBloc>().state.date.toTimeOfDay(),
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (BuildContext context, Widget? child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (timeOfDay == null) return;
    _saveTime(timeOfDay);
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<AddNoteBloc, AddNoteState>(
        builder: (context, state) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              state.date.toTimeOnly(),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              style: AppButtonStyle.buttonDateTimeStyle,
              onPressed: setTime,
              child: Text(
                'Выбрать время ${state.inTwoHoursPeriod}',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      );
}

class _MoodFacesRow extends StatelessWidget {
  const _MoodFacesRow();

  void selectMood(BuildContext context, int moodId) {
    context.read<AddNoteBloc>().add(AddNoteEvent$MoodChange(moodId));
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<AddNoteBloc, AddNoteState>(
        builder: (context, addNotesState) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            5,
            (index) {
              final mood = MoodsStorage.values[index];
              return MoodIcon(
                iconPath: mood.selectedIcon,
                unselectedPath: mood.unSelectedIcon,
                onTap: () => selectMood(context, index),
                selected: mood.id == addNotesState.moodId,
              );
            },
          ),
        ),
      );
}

class _SleepRowWidget extends StatelessWidget {
  const _SleepRowWidget();

  void _onSleepSelect(BuildContext context, GradeLabel? gradeLabel) {
    if (gradeLabel == null) return;
    context
        .read<AddNoteBloc>()
        .add(AddNoteEvent$SleepGradeChange(gradeLabel.index));
  }

  void _onSleepDescriptionChanged(BuildContext context, String v) {
    context.read<AddNoteBloc>().add(AddNoteEvent$SleepDescriptionChange(v));
  }

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: BlocBuilder<AddNoteBloc, AddNoteState>(
              builder: (context, addNoteState) => DropdownMenu(
                initialSelection:
                    GradeLabel.values.elementAt(addNoteState.sleepId),
                onSelected: (v) => _onSleepSelect(context, v),
                inputDecorationTheme: const InputDecorationTheme(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  border: OutlineInputBorder(),
                ),
                label: const Text(
                  'Оценка сна',
                  style: AppTextStyle.dropdownLabel,
                ),
                textStyle: const TextStyle(fontSize: 15),
                dropdownMenuEntries: GradeLabel.values
                    .map<DropdownMenuEntry<GradeLabel>>(
                      (GradeLabel grade) => DropdownMenuEntry<GradeLabel>(
                        value: grade,
                        label: grade.title,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: TextField(
              onChanged: (v) => _onSleepDescriptionChanged(context, v),
              maxLines: 1,
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                labelText: 'Описание сна',
              ),
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      );
}

class _FoodRowWidget extends StatelessWidget {
  const _FoodRowWidget();

  void _onFoodSelect(BuildContext context, GradeLabel? gradeLabel) {
    if (gradeLabel == null) return;
    context
        .read<AddNoteBloc>()
        .add(AddNoteEvent$FoodGradeChange(gradeLabel.index));
  }

  void _onFoodDescriptionChanged(BuildContext context, String v) {
    context.read<AddNoteBloc>().add(AddNoteEvent$SleepDescriptionChange(v));
  }

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: BlocBuilder<AddNoteBloc, AddNoteState>(
              builder: (context, addNoteState) => DropdownMenu<GradeLabel>(
                initialSelection:
                    GradeLabel.values.elementAt(addNoteState.foodId),
                onSelected: (v) => _onFoodSelect(context, v),
                inputDecorationTheme: const InputDecorationTheme(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  border: OutlineInputBorder(),
                ),
                label: const Text(
                  'Оценка еды',
                  style: AppTextStyle.dropdownLabel,
                ),
                textStyle: const TextStyle(fontSize: 15),
                dropdownMenuEntries: GradeLabel.values
                    .map<DropdownMenuEntry<GradeLabel>>(
                      (GradeLabel grade) => DropdownMenuEntry<GradeLabel>(
                        value: grade,
                        label: grade.title,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: TextField(
              onChanged: (v) => _onFoodDescriptionChanged(context, v),
              maxLines: 1,
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                labelText: 'Описание еды',
              ),
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      );
}

class _AddNoteButton extends StatelessWidget {
  const _AddNoteButton();

  Future<void> _onAddButton(BuildContext context) async {
    context.read<AddNoteBloc>().add(AddNoteEvent$Submit());
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<AddNoteBloc, AddNoteState>(
        builder: (context, addNoteState) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: OutlinedButton(
            style: AppButtonStyle.addNoteButtonStyle,
            onPressed: addNoteState.inTwoHoursPeriod ?? true
                ? () => _onAddButton(context)
                : null,
            child: const Text(
              'Добавить запись',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
      );
}
