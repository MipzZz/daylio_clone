import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/core/utils/extensions/date_time_extension.dart';
import 'package:daylio_clone/src/core/utils/extensions/time_of_day_extension.dart';
import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/grade_label.dart';
import 'package:daylio_clone/src/features/notes/domain/provider/add_note_provider/add_note_provider.dart';
import 'package:daylio_clone/src/features/notes/domain/provider/add_note_provider/add_note_state.dart';
import 'package:daylio_clone/src/features/notes/presentation/widgets/alert_failure_dialog_widget.dart';
import 'package:daylio_clone/src/features/notes/presentation/widgets/mood_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNoteWidget extends StatefulWidget {
  const AddNoteWidget({super.key});

  @override
  State<AddNoteWidget> createState() => _AddNoteWidgetState();
}

class _AddNoteWidgetState extends State<AddNoteWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          AddNoteProvider(notesRepository: context.read<NotesRepository>()),
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
  DateTime selectedDate = DateTime.now();

  void saveDate(DateTime date) {
    context.read<AddNoteProvider>().saveDate(date);
  }

  void selectDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      saveDate(date);
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          selectedDate.dateOnly(),
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.black45,
            foregroundColor: Colors.white,
          ),
          onPressed: () => selectDate(),
          child: const Text(
            'Выбрать дату',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
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

  void saveTime(TimeOfDay timeOfDay) {
    context.read<AddNoteProvider>().saveTime(timeOfDay);
  }

  void setTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (timeOfDay != null) {
      saveTime(timeOfDay);
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          selectedTime.timeOnly(),
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black45),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: setTime,
          child: const Text(
            'Выбрать время',
            style: TextStyle(fontSize: 12),
          ),
        )
      ],
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
    context.read<AddNoteProvider>().saveMood(moodId);
  }

  @override
  Widget build(BuildContext context) => Consumer<AddNoteProvider>(
        builder: (context, addNotesVM, child) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            5,
            (index) {
              final mood = addNotesVM.moods[index];
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
    context.read<AddNoteProvider>().saveSelectedSleep(initialSelect.index);
  }

  void _onSleepSelect(GradeLabel? gradeLabel) {
    if (gradeLabel == null) return;
    context.read<AddNoteProvider>().saveSelectedSleep(gradeLabel.index);
  }

  void _onSleepDescriptionChanged(String v) {
    context.read<AddNoteProvider>().saveSleepDescription(v);
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
    context.read<AddNoteProvider>().saveSelectedFood(initialSelect.index);
  }

  void _onFoodSelect(GradeLabel? gradeLabel) {
    if (gradeLabel == null) return;
    context.read<AddNoteProvider>().saveSelectedFood(gradeLabel.index);
  }

  void _onFoodDescriptionChanged(String v) {
    context.read<AddNoteProvider>().saveFoodDescription(v);
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
    await context.read<AddNoteProvider>().saveNote();
    if (!context.mounted) return;
    switch (context.read<AddNoteProvider>().state) {
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
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.mainGreen,
          foregroundColor: Colors.white,
          side: const BorderSide(
            color: AppColors.mainGreen,
            width: 2,
          ),
        ),
        onPressed: () => _onAddButton(context),
        child: const Text('Добавить запись', style: TextStyle(fontSize: 15)),
      ),
    );
  }
}
