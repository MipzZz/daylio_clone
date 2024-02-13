import 'package:daylio_clone/src/core/presentation/assets/buttons/app_button_style.dart';
import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/core/utils/extensions/date_time_extension.dart';
import 'package:daylio_clone/src/core/utils/extensions/time_of_day_extension.dart';
import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/grade_label.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/moods_storage.dart';
import 'package:daylio_clone/src/features/notes/domain/provider/add_note_bloc/add_note_bloc.dart';
import 'package:daylio_clone/src/features/notes/domain/provider/add_note_bloc/add_note_events.dart';
import 'package:daylio_clone/src/features/notes/domain/provider/add_note_bloc/add_note_state.dart';
import 'package:daylio_clone/src/features/notes/presentation/widgets/alert_failure_dialog_widget.dart';
import 'package:daylio_clone/src/features/notes/presentation/widgets/mood_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';


class AddNoteWidget extends StatefulWidget {
  const AddNoteWidget({super.key});

  @override
  State<AddNoteWidget> createState() => _AddNoteWidgetState();
}

class _AddNoteWidgetState extends State<AddNoteWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddNoteBloc(notesRepository: context.read<NotesRepository>()),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Новая запись'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: const [
                DateNTimeRow(),
                SizedBox(height: 30),
                _MoodFacesRow(),
                SizedBox(height: 30),
                _SleepRowWidget(),
                SizedBox(height: 50),
                _FoodRowWidget(),
                SizedBox(height: 35),
                _AddNoteButton(),
                //ToDo Добавить кнопку сброса
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DateNTimeRow extends StatelessWidget {
  const DateNTimeRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: _DatePickerWidget()),
        Expanded(child: _TimePickerWidget()),
      ],
    );
  }
}

class _DatePickerWidget extends StatefulWidget {
  const _DatePickerWidget();

  @override
  State<_DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<_DatePickerWidget> {


  void _saveDate(DateTime date) {
    context.read<AddNoteBloc>().add(AddNoteDateChangeEvent(date));
  }

  void selectDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: context.read<AddNoteBloc>().state.date,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
      builder: (context, child) {
        if (child == null) {
          return const SizedBox(
            child: Text('Непердвиденная ошибка'),
          );
        }
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  onSurface: Colors.white,
                ),
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        foregroundColor:
                        const Color.fromARGB(255, 180, 135, 218)))),
            child: child);
      },
    );
    if (date != null) {
      _saveDate(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNoteBloc, AddNoteState>(
      builder: (context,state) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            state.date.dateOnly(),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            style: AppButtonStyle.buttonDateTimeStyle,
            onPressed: () => selectDate(),
            child: const Text(
              'Выбрать дату',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimePickerWidget extends StatefulWidget {
  const _TimePickerWidget();

  @override
  State<_TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<_TimePickerWidget> {
  TimeOfDay selectedTime = TimeOfDay.now();

  void _saveTime(TimeOfDay timeOfDay) {
    context.read<AddNoteBloc>().add(AddNoteTimeChangeEvent(timeOfDay));
  }

  void setTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: context.read<AddNoteBloc>().state.date.toTimeOfDay(),
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (timeOfDay != null) {
      _saveTime(timeOfDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNoteBloc, AddNoteState>(
      builder: (context,state) =>  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            state.date.toTimeOfDay().timeOnly(),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            style: AppButtonStyle.buttonDateTimeStyle,
            onPressed: setTime,
            child: const Text(
              'Выбрать время',
              style: TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}

class _MoodFacesRow extends StatefulWidget {
  const _MoodFacesRow();

  @override
  State<_MoodFacesRow> createState() => _MoodFacesRowState();
}

class _MoodFacesRowState extends State<_MoodFacesRow> {

  void selectMood(int moodId) {
    context.read<AddNoteBloc>().add(AddNoteMoodChangeEvent(moodId));
  }

  @override
  Widget build(BuildContext context) => Consumer<AddNoteBloc>(
        builder: (context, addNotesVM, child) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            5,
            (index) {
              final mood = MoodsStorage.values[index];
              return MoodIcon(
                iconPath: mood.selectedIcon,
                unselectedPath: mood.unSelectedIcon,
                onTap: () => selectMood(index),
                selected: mood.id == addNotesVM.state.moodId,
              );
            },
          ),
        ),
      );
}

class _SleepRowWidget extends StatefulWidget {
  const _SleepRowWidget();

  @override
  State<_SleepRowWidget> createState() => _SleepRowWidgetState();
}

class _SleepRowWidgetState extends State<_SleepRowWidget> {
  final initialSelect = GradeLabel.excellent;

  @override
  void initState() {
    super.initState();
    context.read<AddNoteBloc>().add(AddNoteSleepChangeGradeEvent(initialSelect.index));
  }

  void _onSleepSelect(GradeLabel? gradeLabel) {
    if (gradeLabel == null) return;
    context.read<AddNoteBloc>().add(AddNoteSleepChangeGradeEvent(gradeLabel.index));
  }

  void _onSleepDescriptionChanged(String v) {
    context.read<AddNoteBloc>().add(AddNoteSleepChangeDescriptionEvent(v));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: DropdownMenu(
            initialSelection: initialSelect,
            onSelected: _onSleepSelect,
            inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              border: OutlineInputBorder(),
            ),
            label: const Text('Оценка сна'),
            textStyle: const TextStyle(fontSize: 15),
            dropdownMenuEntries: GradeLabel.values
                .map<DropdownMenuEntry<GradeLabel>>((GradeLabel grade) {
              return DropdownMenuEntry<GradeLabel>(
                value: grade,
                label: grade.title,
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: TextField(
            onChanged: _onSleepDescriptionChanged,
            maxLines: 1,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Описание сна',
            ),
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}

class _FoodRowWidget extends StatefulWidget {
  const _FoodRowWidget();

  @override
  State<_FoodRowWidget> createState() => _FoodRowWidgetState();
}

class _FoodRowWidgetState extends State<_FoodRowWidget> {
  final initialSelect = GradeLabel.excellent;

  @override
  void initState() {
    super.initState();
    context.read<AddNoteBloc>().add(AddNoteFoodChangeGradeEvent(initialSelect.index));
  }

  void _onFoodSelect(GradeLabel? gradeLabel) {
    if (gradeLabel == null) return;
    context.read<AddNoteBloc>().add(AddNoteFoodChangeGradeEvent(gradeLabel.index));
  }

  void _onFoodDescriptionChanged(String v) {
    context.read<AddNoteBloc>().add(AddNoteSleepChangeDescriptionEvent(v));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: DropdownMenu<GradeLabel>(
            initialSelection: initialSelect,
            onSelected: _onFoodSelect,
            inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              border: OutlineInputBorder(),
            ),
            label: const Text('Оценка еды'),
            textStyle: const TextStyle(fontSize: 15),
            dropdownMenuEntries: GradeLabel.values
                .map<DropdownMenuEntry<GradeLabel>>((GradeLabel grade) {
              return DropdownMenuEntry<GradeLabel>(
                value: grade,
                label: grade.title,
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: TextField(
            onChanged: _onFoodDescriptionChanged,
            maxLines: 1,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Описание еды',
            ),
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}

class _AddNoteButton extends StatelessWidget {
  const _AddNoteButton();

  void _onAddButton(BuildContext context) async {
    context.read<AddNoteBloc>().add(AddNoteSubmitEvent());
    if (!context.mounted) return;
    switch (context.read<AddNoteBloc>().state) {
      case AddNoteStateError(message: final message):
        showDialog(
            context: context,
            builder: (_) {
              return AlertFailureDialogWidget(
                message: message,
              );
            });
      default:
        Navigator.popUntil(context, ModalRoute.withName('/'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: OutlinedButton(
        style: AppButtonStyle.addNoteButtonStyle,
        onPressed: () => _onAddButton(context),
        child: const Text('Добавить запись', style: TextStyle(fontSize: 15)),
      ),
    );
  }
}
