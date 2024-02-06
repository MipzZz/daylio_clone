import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/grade_label.dart';
import 'package:daylio_clone/src/features/notes/domain/provider/notes_details_provider/note_details_state.dart';
import 'package:daylio_clone/src/features/notes/domain/provider/notes_details_provider/notes_details_provider.dart';
import 'package:daylio_clone/src/features/notes/presentation/widgets/mood_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteDetailsWidget extends StatefulWidget {
  final int noteId;

  const NoteDetailsWidget({super.key, required this.noteId});

  @override
  State<NoteDetailsWidget> createState() => _NoteDetailsWidgetState();
}

class _NoteDetailsWidgetState extends State<NoteDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotesDetailsProvider(
          notesRepository: context.read<NotesRepository>(), id: widget.noteId),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: _SaveButton(),
            )
          ],
          title: Text(
              'Запись ${widget.noteId}'), //TODO Сделать корректное название записи
        ),
        body: const _SwitchWidget(),
      ),
    );
  }
}

class _SwitchWidget extends StatelessWidget {
  const _SwitchWidget();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotesDetailsProvider>();
    return switch (viewModel.state.runtimeType) {
      NoteDetailsStateInitial => const Text('Инициализация'),
      NoteDetailsStateError =>  _AlertDialogFailureWidget(message: (viewModel.state as NoteDetailsStateError).message),
      _ => const _DefaultBodyWidget(),
    };
  }
}

class _DefaultBodyWidget extends StatelessWidget {
  const _DefaultBodyWidget();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
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
    );
  }
}

class _DateNTimeRow extends StatelessWidget {
  const _DateNTimeRow();

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
  void selectDate(DateTime? selectedDate) async {
    if (selectedDate == null) {
      return;
    }
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      setState(() {
        context.read<NotesDetailsProvider>().updateDate(date);
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate =
        context.watch<NotesDetailsProvider>().state.note?.date;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${selectedDate?.day}.${selectedDate?.month}.${selectedDate?.year}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.black45,
            foregroundColor: Colors.white,
          ),
          onPressed: () => selectDate(selectedDate),
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
  void setTime(TimeOfDay selectedTime) async {
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
      setState(() {
        context.read<NotesDetailsProvider>().updateTime(timeOfDay);
        selectedTime = timeOfDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TimeOfDay selectedTime = TimeOfDay.fromDateTime(
        context.watch<NotesDetailsProvider>().state.note?.date ??
            DateTime.now());

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
          onPressed: () => setTime(selectedTime),
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
  void selectMood(int index) {
    var activeMoodId = context.read<NotesDetailsProvider>().state.note?.mood.id;
    if (activeMoodId == index) return;
    context.read<NotesDetailsProvider>().setActiveMood(index);
    setState(() {
      activeMoodId = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final noteDetailsVM = context.watch<NotesDetailsProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        5,
        (index) {
          final mood = noteDetailsVM.moods[index];
          return MoodIcon(
            iconPath: mood.selectedIcon,
            unselectedPath: mood.unSelectedIcon,
            onTap: () => selectMood(index),
            selected: mood.id == noteDetailsVM.state.note?.mood.id,
          );
        },
      ),
    );
  }
}

class _SleepRowWidget extends StatelessWidget {
  const _SleepRowWidget();

  @override
  Widget build(BuildContext context) {
    final description =
        context.watch<NotesDetailsProvider>().state.note?.sleep.description;
    final sleepDescriptionController = TextEditingController(text: description);
    final id = context.watch<NotesDetailsProvider>().state.note?.sleep.id;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: DropdownMenu<GradeLabel>(
            initialSelection: GradeLabel.values[id ?? 0],
            onSelected: (value) =>
                context.read<NotesDetailsProvider>().updateSleepGrade(value),
            label: const Text('Оценка сна'),
            inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              border: OutlineInputBorder(),
            ),
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
            controller: sleepDescriptionController,
            onChanged: (text) => context
                .read<NotesDetailsProvider>()
                .updateSleepDescription(text),
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
    final description =
        context.watch<NotesDetailsProvider>().state.note?.food.description;
    final foodDescriptionController = TextEditingController(text: description);
    final id = context.watch<NotesDetailsProvider>().state.note?.food.id;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: DropdownMenu<GradeLabel>(
            initialSelection: GradeLabel.values[id ?? 0],
            onSelected: (value) =>
                context.read<NotesDetailsProvider>().updateFoodGrade(value),
            label: const Text('Оценка сна'),
            inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              border: OutlineInputBorder(),
            ),
            textStyle: const TextStyle(fontSize: 15),
            dropdownMenuEntries:
                GradeLabel.values.map<DropdownMenuEntry<GradeLabel>>(
              (GradeLabel grade) {
                return DropdownMenuEntry<GradeLabel>(
                  value: grade,
                  label: grade.title,
                );
              },
            ).toList(),
          ),
        ),
        Expanded(
          child: TextField(
            controller: foodDescriptionController,
            onChanged: (text) => context
                .read<NotesDetailsProvider>()
                .updateFoodDescription(text),
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

class _DeleteButton extends StatelessWidget {
  const _DeleteButton();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotesDetailsProvider>();
    final noteId = viewModel.state.note?.id;
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(color: Colors.redAccent, width: 2),
        ),
      ),
      onPressed: () {
        if (noteId != null) {
          viewModel.deleteNote(id: noteId).then((_) {
            switch (viewModel.state.runtimeType) {
              case NoteDetailsStateError:
                showDialog(
                  context: context,
                  builder: (_) {
                    return _AlertDialogFailureWidget(
                        message:
                            (viewModel.state as NoteDetailsStateError).message);
                  },
                );
              default:
                Navigator.popUntil(context, ModalRoute.withName('/'));
            }
          });
        }
      },
      child: const Text('Удалить запись', style: TextStyle(fontSize: 15)),
    );
  }
}

class _AlertDialogFailureWidget extends StatelessWidget {
  final String message;

  const _AlertDialogFailureWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: const Text('Ошибочка'),
      content: Text(message),
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

class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotesDetailsProvider>();
    return IconButton(
      onPressed: () {
        viewModel.updateNote().then((_) {
          switch (viewModel.state.runtimeType) {
            case NoteDetailsStateError:
              showDialog(
                context: context,
                builder: (_) {
                  return _AlertDialogFailureWidget(
                      message:
                          (viewModel.state as NoteDetailsStateError).message);
                },
              );
            default:
              break;
          }
        });
      },
      icon: const Icon(Icons.save),
    );
  }
}
