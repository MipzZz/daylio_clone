import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/core/presentation/assets/res/app_icons.dart';
import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/grade_label.dart';
import 'package:daylio_clone/src/features/notes/domain/provider/add_note_provider/add_note_provider.dart';
import 'package:daylio_clone/src/features/notes/domain/provider/add_note_provider/add_note_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Добавить запись'),
        ),
        body: const SingleChildScrollView(
          //TODO Переделать в ListView
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DateNTimeRow(),
                SizedBox(height: 30),
                _MoodFacesRow(),
                SizedBox(height: 30),
                _SleepRowWidget(),
                SizedBox(height: 50),
                _FoodRowWidget(),
                SizedBox(height: 50),
                _AddNoteButton(),
                //ToDO Добавить кнопку сброса
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AddNoteButton extends StatelessWidget {
  const _AddNoteButton();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddNoteProvider>();
    return OutlinedButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColors.mainGreen),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(color: AppColors.mainGreen, width: 2),
          )),
      onPressed: () {
        //TODO Не появляется окно с ошибкой
        viewModel.saveNote().then((_) {
          switch (viewModel.state) {
            case AddNoteStateError():
              showDialog(
                context: context,
                builder: (_) {
                  return ChangeNotifierProvider.value(
                    value: context.read<AddNoteProvider>(),
                    child: const _AlertFailureDialogWidget(),
                  );
                },
              );
            default:
              Navigator.popUntil(context, ModalRoute.withName('/'));
          }
        });
      },
      child: const Text('Добавить запись', style: TextStyle(fontSize: 15)),
    );
  }
}

class _AlertFailureDialogWidget extends StatelessWidget {
  const _AlertFailureDialogWidget();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddNoteProvider>().state;
    return AlertDialog(
      backgroundColor: Colors.black,
      title: const Text('Ошибочка'),
      content: Text('(state as AddNoteStateError).message'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
          child: const Text(
            'Ok',
            style: TextStyle(color: AppColors.mainGreen),
          ),
        ),
      ],
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

class _SleepRowWidget extends StatelessWidget {
  const _SleepRowWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: DropdownMenu(
            onSelected: (value) {
              context.read<AddNoteProvider>().saveSelectedSleep(value);
            },
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
            onChanged: (text) =>
                context.read<AddNoteProvider>().saveSleepDescription(text),
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

class _FoodRowWidget extends StatelessWidget {
  const _FoodRowWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: DropdownMenu<GradeLabel>(
            onSelected: (value) {
              context.read<AddNoteProvider>().saveSelectedFood(value);
            },
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
            onChanged: (text) =>
                context.read<AddNoteProvider>().saveFoodDescription(text),
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
        });
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
          '${selectedTime.hour}:${selectedTime.minute}',
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
          '${selectedDate.day}.${selectedDate.month}.${selectedDate.year}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.black45,
            foregroundColor: Colors.white,
          ),
          onPressed: () => {
            selectDate(),
          },
          child: const Text(
            'Выбрать дату',
            style: TextStyle(fontSize: 12),
          ),
        ),
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
  Widget build(BuildContext context) {
    final addNotesVM = context.watch<AddNoteProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        5,
        (index) {
          final mood = addNotesVM.moods[index];

          return MoodIcon(
            iconPath: mood.selectedIcon,
            unselectedPath: mood.unSelectedIcon,
            onTap: () => selectMood(index),
            selected: mood.id == addNotesVM.state.note?.mood.id,
          );
        },
      ),
      // [
      //   GestureDetector(
      //     onTap: () {
      //       selectMood(0);
      //     },
      //     child: SvgPicture.asset(
      //       _activeMoodId == 0
      //           ? moods[0].icon['selected'] ?? AppIcons.badRegular
      //           : moods[0].icon['notSelected'] ?? AppIcons.badRegular,
      //       width: 50,
      //       height: 50,
      //     ),
      //   ),
      //   GestureDetector(
      //     onTap: () {
      //       selectMood(1);
      //     },
      //     child: SvgPicture.asset(
      //       _activeMoodId == 1
      //           ? moods[1].icon['selected'] ?? AppIcons.badRegular
      //           : moods[1].icon['notSelected'] ?? AppIcons.badRegular,
      //       width: 50,
      //       height: 50,
      //     ),
      //   ),
      //   GestureDetector(
      //     onTap: () {
      //       selectMood(2);
      //     },
      //     child: SvgPicture.asset(
      //       _activeMoodId == 2
      //           ? moods[2].icon['selected'] ?? AppIcons.badRegular
      //           : moods[2].icon['notSelected'] ?? AppIcons.badRegular,
      //       width: 50,
      //       height: 50,
      //     ),
      //   ),
      //   GestureDetector(
      //     onTap: () {
      //       selectMood(3);
      //     },
      //     child: SvgPicture.asset(
      //       _activeMoodId == 3
      //           ? moods[3].icon['selected'] ?? AppIcons.goodRegular
      //           : moods[3].icon['notSelected'] ?? AppIcons.goodRegular,
      //       width: 50,
      //       height: 50,
      //     ),
      //   ),
      //   GestureDetector(
      //     onTap: () {
      //       selectMood(4);
      //     },
      //     child: SvgPicture.asset(
      //       _activeMoodId == 4
      //           ? moods[4].icon['selected'] ?? AppIcons.badRegular
      //           : moods[4].icon['notSelected'] ?? AppIcons.badRegular,
      //       width: 50,
      //       height: 50,
      //     ),
      //   ),
      // ],
    );
  }
}

class MoodIcon extends StatelessWidget {
  final String? iconPath;
  final String? unselectedPath;
  final bool selected;

  final VoidCallback onTap;

  const MoodIcon({
    super.key,
    required this.iconPath,
    required this.unselectedPath,
    required this.onTap,
    required this.selected,
  });

  String get _iconPath =>
      (selected ? iconPath : unselectedPath) ?? AppIcons.badRegular;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      _iconPath,
      width: 50,
      height: 50,
    );
  }
}
