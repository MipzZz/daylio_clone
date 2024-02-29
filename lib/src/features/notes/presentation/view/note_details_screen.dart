import 'package:daylio_clone/src/core/presentation/assets/buttons/app_button_style.dart';
import 'package:daylio_clone/src/core/presentation/assets/text/app_text_style.dart';
import 'package:daylio_clone/src/core/utils/extensions/date_time_extension.dart';
import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_details_bloc/note_details_bloc.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_details_bloc/note_details_event.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_details_bloc/note_details_state.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/grade_label.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/moods_storage.dart';
import 'package:daylio_clone/src/features/notes/presentation/widgets/alert_failure_dialog_widget.dart';
import 'package:daylio_clone/src/features/notes/presentation/widgets/build_blur.dart';
import 'package:daylio_clone/src/features/notes/presentation/widgets/mood_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteDetailsWidget extends StatefulWidget {
  const NoteDetailsWidget({super.key, required this.noteId});

  final int noteId;

  @override
  State<NoteDetailsWidget> createState() => _NoteDetailsWidgetState();
}

class _NoteDetailsWidgetState extends State<NoteDetailsWidget> {
  late final NoteDetailsBloc _noteDetailsBloc;

  @override
  void initState() {
    _noteDetailsBloc = NoteDetailsBloc(
      notesRepository: context.read<NotesRepository>(),
    )..add(NoteDetailsEvent$LoadNote(widget.noteId));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _noteDetailsListener(BuildContext context, NoteDetailsState state) {
    switch (state) {
      case NoteDetailsState$Completed():
        Navigator.of(context).pop();
      case final NoteDetailsState$Error errorState:
        showDialog<AlertFailureDialogWidget>(
          context: context,
          builder: (_) => AlertFailureDialogWidget(message: errorState.message),
        );
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => _noteDetailsBloc,
        child: BlocConsumer<NoteDetailsBloc, NoteDetailsState>(
          listenWhen: (previous, current) =>
              previous is! NoteDetailsState$Initial,
          listener: _noteDetailsListener,
          builder: (context, state) => switch (state) {
            NoteDetailsState$Initial() => Scaffold(
                appBar: AppBar(),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            NoteDetailsState$Progress() => Stack(
                children: [
                  PopScope(
                    canPop: false, //Можно ли свайпнуть для возврата
                    child: AbsorbPointer(
                      absorbing: true, //Состояние абсорба нажатий
                      child: buildBlur(
                        isLoading: true, //Состояние блюра
                        child: const _DefaultBodyWidget(),
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
            NoteDetailsState$Error() => Scaffold(
                appBar: AppBar(),
                body: const Center(
                  child: Text('К сожалению, не получилось загрузить запись'),
                ),
              ),
            _ => const _DefaultBodyWidget(),
          },
        ),
      );
}

class _DefaultBodyWidget extends StatelessWidget {
  const _DefaultBodyWidget();

  void _unFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: _SaveButton(),
            ),
          ],
          title: BlocBuilder<NoteDetailsBloc, NoteDetailsState>(
            builder: (context, state) => Text(
              'Запись от '
              '${context.read<NoteDetailsBloc>().state.date.dateOnly()}',
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () => _unFocus(context),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: const [
                _DateNTimeRow(),
                SizedBox(height: 45),
                _MoodFacesRow(),
                SizedBox(height: 50),
                _SleepRowWidget(),
                SizedBox(height: 50),
                _FoodRowWidget(),
                SizedBox(height: 30),
                _DeleteButton(),
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
  void _updateDate(DateTime date) {
    context.read<NoteDetailsBloc>().add(NoteDetailsEvent$DateChange(date));
  }

  Future<void> selectDate(DateTime selectedDate) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      _updateDate(date);
    }
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<NoteDetailsBloc, NoteDetailsState>(
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
              onPressed: () => selectDate(state.date),
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
  void _updateTime(TimeOfDay selectedTime) {
    context
        .read<NoteDetailsBloc>()
        .add(NoteDetailsEvent$TimeChange(selectedTime));
  }

  Future<void> setTime(TimeOfDay selectedTime) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (BuildContext context, Widget? child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (timeOfDay != null) {
      _updateTime(timeOfDay);
    }
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<NoteDetailsBloc, NoteDetailsState>(
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
              onPressed: () => setTime(state.date.toTimeOfDay()),
              child: const Text(
                'Выбрать время',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      );
}

class _MoodFacesRow extends StatefulWidget {
  const _MoodFacesRow();

  @override
  State<_MoodFacesRow> createState() => _MoodFacesRowState();
}

class _MoodFacesRowState extends State<_MoodFacesRow> {
  void selectMood(int moodId) {
    context.read<NoteDetailsBloc>().add(NoteDetailsEvent$MoodChange(moodId));
  }

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          5,
          (index) {
            final mood = MoodsStorage.values[index];
            return BlocBuilder<NoteDetailsBloc, NoteDetailsState>(
              builder: (context, state) => MoodIcon(
                iconPath: mood.selectedIcon,
                unselectedPath: mood.unSelectedIcon,
                onTap: () => selectMood(index),
                selected: mood.id == state.moodId,
              ),
            );
          },
        ),
      );
}

class _SleepRowWidget extends StatefulWidget {
  const _SleepRowWidget();

  @override
  State<_SleepRowWidget> createState() => _SleepRowWidgetState();
}

class _SleepRowWidgetState extends State<_SleepRowWidget> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    final initialSleepDescription =
        context.read<NoteDetailsBloc>().state.sleepDescription;
    _textController = TextEditingController(text: initialSleepDescription);
  }

  void _onSleepSelect(GradeLabel? gradeLabel) {
    if (gradeLabel == null) return;
    context
        .read<NoteDetailsBloc>()
        .add(NoteDetailsEvent$SleepGradeChange(gradeLabel.index));
  }

  void _onSleepDescriptionChanged(String v) {
    context
        .read<NoteDetailsBloc>()
        .add(NoteDetailsEvent$SleepDescriptionChange(v));
  }

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: BlocBuilder<NoteDetailsBloc, NoteDetailsState>(
              builder: (context, state) => DropdownMenu<GradeLabel>(
                initialSelection: GradeLabel.values[state.sleepId],
                onSelected: _onSleepSelect,
                label: const Text(
                  'Оценка сна',
                  style: AppTextStyle.dropdownLabel,
                ),
                inputDecorationTheme: const InputDecorationTheme(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(),
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
              controller: _textController,
              onChanged: _onSleepDescriptionChanged,
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

class _FoodRowWidget extends StatefulWidget {
  const _FoodRowWidget();

  @override
  State<_FoodRowWidget> createState() => _FoodRowWidgetState();
}

class _FoodRowWidgetState extends State<_FoodRowWidget> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    final initialFoodDescription =
        context.read<NoteDetailsBloc>().state.foodDescription;
    _textController = TextEditingController(text: initialFoodDescription);
  }

  void _onFoodSelect(GradeLabel? gradeLabel) {
    if (gradeLabel == null) return;
    context
        .read<NoteDetailsBloc>()
        .add(NoteDetailsEvent$FoodGradeChange(gradeLabel.index));
  }

  void _onFoodDescriptionChanged(String v) {
    context
        .read<NoteDetailsBloc>()
        .add(NoteDetailsEvent$FoodDescriptionChange(v));
  }

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: BlocBuilder<NoteDetailsBloc, NoteDetailsState>(
              builder: (context, state) => DropdownMenu<GradeLabel>(
                initialSelection: GradeLabel.values[state.foodId],
                onSelected: _onFoodSelect,
                label: const Text(
                  'Оценка еды',
                  style: AppTextStyle.dropdownLabel,
                ),
                inputDecorationTheme: const InputDecorationTheme(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  border: OutlineInputBorder(),
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
              controller: _textController,
              onChanged: _onFoodDescriptionChanged,
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

class _DeleteButton extends StatelessWidget {
  const _DeleteButton();

  void _onDeleteButton(BuildContext context) {
    context.read<NoteDetailsBloc>().add(const NoteDetailsEvent$Delete());
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        child: OutlinedButton(
          style: AppButtonStyle.deleteNoteButtonStyle,
          onPressed: () => _onDeleteButton(context),
          child: const Text('Удалить запись', style: TextStyle(fontSize: 15)),
        ),
      );
}

class _SaveButton extends StatelessWidget {
  const _SaveButton();

  void _onSaveButton(BuildContext context) {
    context.read<NoteDetailsBloc>().add(const NoteDetailsEvent$Save());
  }

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () => _onSaveButton(context),
        icon: const Icon(Icons.save),
      );
}
