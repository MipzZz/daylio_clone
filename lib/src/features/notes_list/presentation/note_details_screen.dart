import 'package:daylio_clone/src/core/presentation/assets/res/app_icons.dart';
import 'package:daylio_clone/src/features/notes_list/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes_list/domain/entity/grade_label.dart';
import 'package:daylio_clone/src/features/notes_list/domain/provider/notes_details_provider/notes_details_provider.dart';
import 'package:daylio_clone/src/features/notes_list/domain/provider/notes_provider/notes_provider.dart';
import 'package:daylio_clone/src/features/widgets/date_picker_widget.dart';
import 'package:daylio_clone/src/features/widgets/dropdown_widget.dart';
import 'package:daylio_clone/src/features/widgets/time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final id = widget.noteId;
    final notesRepository = context.read<NotesRepository>();
    return ChangeNotifierProvider(
      create: (context) =>
          NotesDetailsProvider(notesRepository: notesRepository, id: id),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: _SaveButton(),
            )
          ],
          title: Text(widget.noteId.toString()),
        ),
        body: const Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              _DateNTimeRow(),
              SizedBox(height: 45),
              _MoodFacesRow(),
              SizedBox(height: 50),
              _MoodDescriptionWidget(),
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
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<NotesDetailsProvider>().updateNote(),
      icon: const Icon(Icons.save),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<NotesProvider>();
    return OutlinedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(color: Colors.redAccent, width: 2),
          )),
      onPressed: () {
        final id = context.read<NotesDetailsProvider>().state.note.id;
        viewModel.deleteNote(id: id);
        Navigator.pop(context);
      },
      child: const Text('Удалить запись', style: TextStyle(fontSize: 15)),
    );
  }
}

class _MoodDescriptionWidget extends StatefulWidget {
  const _MoodDescriptionWidget({
    super.key,
  });

  @override
  State<_MoodDescriptionWidget> createState() => _MoodDescriptionWidgetState();
}

class _MoodDescriptionWidgetState extends State<_MoodDescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    final moodController = TextEditingController(
        text: context.watch<NotesDetailsProvider>().state.note.mood);
    return TextField(
      controller: moodController,
      maxLines: 1,
      onChanged: (text) => Provider.of<NotesDetailsProvider>(context, listen: false).setMood(text),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Описание настроения',
      ),
      style: const TextStyle(fontSize: 10),
    );
  }
}

class _DateNTimeRow extends StatelessWidget {
  const _DateNTimeRow({
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

class _MoodFacesRow extends StatelessWidget {
  const _MoodFacesRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: GestureDetector(
            // onTap: ,
            child: SvgPicture.asset(
              AppIcons.excellentRegular,
              width: 50,
              height: 50,
            ),
          ),
        ),
        Expanded(
          child: SvgPicture.asset(
            AppIcons.goodRegular,
            width: 50,
            height: 50,
          ),
        ),
        Expanded(
          child: SvgPicture.asset(
            AppIcons.normalRegular,
            width: 50,
            height: 50,
          ),
        ),
        Expanded(
          child: SvgPicture.asset(
            AppIcons.badRegular,
            width: 50,
            height: 50,
          ),
        ),
        Expanded(
          child: SvgPicture.asset(
            AppIcons.terribleRegular,
            width: 50,
            height: 50,
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
    final _sleepController = TextEditingController();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: DropdownMenu<GradeLabel>(
            initialSelection: GradeLabel.good,
            controller: _sleepController,
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
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: DropdownMenuWidget(
            labelText: 'Оценка еды',
          ),
        ),
        Expanded(
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

class _DatePickerWidget extends StatefulWidget {
  const _DatePickerWidget({
    super.key,
  });

  @override
  State<_DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<_DatePickerWidget> {

  void selectDate(DateTime selectedDate) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      setState(() {
        Provider.of<NotesDetailsProvider>(context, listen: false).setDate(date);
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = context.watch<NotesDetailsProvider>().state.note.date;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${selectedDate.day}.${selectedDate.month}.${selectedDate.year}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black45),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
  const _TimePickerWidget({
    super.key,
  });

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
        Provider.of<NotesDetailsProvider>(context, listen: false).setTime(timeOfDay);
        selectedTime = timeOfDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TimeOfDay selectedTime = TimeOfDay.fromDateTime(context.watch<NotesDetailsProvider>().state.note.date);

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