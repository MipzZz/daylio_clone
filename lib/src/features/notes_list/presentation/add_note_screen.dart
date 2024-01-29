import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/features/notes_list/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes_list/domain/provider/add_note_provider/add_note_provider.dart';
import 'package:daylio_clone/src/features/widgets/date_picker_widget.dart';
import 'package:daylio_clone/src/features/widgets/time_picker_widget.dart';
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
    return Provider(
      create: (context) => AddNoteProvider(notesRepository: NotesRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Добавить запись'),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DateNTimeRow(),
              SizedBox(height: 30),
              _MoodRowWidget(),
              SizedBox(height: 50),
              _SleepRowWidget(),
              SizedBox(height: 50),
              _FoodRowWidget(),
              SizedBox(height: 50),
              _AddNoteButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddNoteButton extends StatelessWidget {
  const _AddNoteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColors.mainGreen),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(color: AppColors.mainGreen, width: 2),
          )),
      onPressed: () {
        context.read<AddNoteProvider>().saveNote;
        Navigator.pop(context);
      },
      child: const Text('Добавить запись', style: TextStyle(fontSize: 15)),
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
        Expanded(child: DatePickerWidget()),
        Expanded(child: TimePickerWidget()),
      ],
    );
  }
}

class _MoodRowWidget extends StatelessWidget {
  const _MoodRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: DropdownMenu(
            onSelected: (value) {
              context.read<AddNoteProvider>().saveMood(value.toString());
            },
            inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              border: OutlineInputBorder(),
            ),
            label: const Text('Оценка настроения'),
            textStyle: const TextStyle(fontSize: 15),
            dropdownMenuEntries: const [
              DropdownMenuEntry(
                value: 1,
                label: 'Отлично',
              ),
              DropdownMenuEntry(
                value: 2,
                label: 'Хорошо',
              ),
              DropdownMenuEntry(
                value: 3,
                label: 'Нормально',
              ),
              DropdownMenuEntry(
                value: 4,
                label: 'Плохо',
              )
            ],
          ),
        ),
        const Expanded(
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Описание настроения',
            ),
            style: TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}

class _SleepRowWidget extends StatelessWidget {
  const _SleepRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: DropdownMenu(
            onSelected: (value) {
              context.read<AddNoteProvider>().saveSleep(value.toString());
            },
            inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              border: OutlineInputBorder(),
            ),
            label: const Text('Оценка сна'),
            textStyle: const TextStyle(fontSize: 15),
            dropdownMenuEntries: const [
              DropdownMenuEntry(
                value: 1,
                label: 'Отлично',
              ),
              DropdownMenuEntry(
                value: 2,
                label: 'Хорошо',
              ),
              DropdownMenuEntry(
                value: 3,
                label: 'Нормально',
              ),
              DropdownMenuEntry(
                value: 4,
                label: 'Плохо',
              )
            ],
          ),
        ),
        const Expanded(
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Описание сна',
            ),
            style: TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}

class _FoodRowWidget extends StatelessWidget {
  const _FoodRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: DropdownMenu(
            onSelected: (value) {
              context.read<AddNoteProvider>().saveFood(value.toString());
            },
            inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              border: OutlineInputBorder(),
            ),
            label: const Text('Оценка еды'),
            textStyle: const TextStyle(fontSize: 15),
            dropdownMenuEntries: const [
              DropdownMenuEntry(
                value: 1,
                label: 'Отлично',
              ),
              DropdownMenuEntry(
                value: 2,
                label: 'Хорошо',
              ),
              DropdownMenuEntry(
                value: 3,
                label: 'Нормально',
              ),
              DropdownMenuEntry(
                value: 4,
                label: 'Плохо',
              )
            ],
          ),
        ),
        const Expanded(
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Описание еды',
            ),
            style: TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}
