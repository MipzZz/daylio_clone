import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:flutter/material.dart';

class AddNoteWidget extends StatefulWidget {
  const AddNoteWidget({super.key});

  @override
  State<AddNoteWidget> createState() => _AddNoteWidgetState();
}

class _AddNoteWidgetState extends State<AddNoteWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить запись'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DateNTimeRow(),
            SizedBox(height: 30),
            MoodRow(),
            SizedBox(height: 50),
            SleepRow(),
            SizedBox(height: 50),
            FoodRow(),
            SizedBox(height: 50),
            OutlinedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.mainGreen),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(color: AppColors.mainGreen, width: 2),
                  )),
              onPressed: () {},
              child:
                  const Text('Добавить запись', style: TextStyle(fontSize: 15)),
            ),
          ],
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
        Expanded(child: DatePickerWidget()),
        Expanded(child: TimePickerWidget()),
      ],
    );
  }
}

class TimePickerWidget extends StatefulWidget {
  const TimePickerWidget({
    super.key,
  });

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay selectedTime = TimeOfDay.now();

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

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({
    super.key,
  });

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime selectedDate = DateTime.now();

  void selectDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (date != null) {
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
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black45),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: selectDate,
          child: const Text(
            'Выбрать дату',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class MoodRow extends StatelessWidget {
  const MoodRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: DropdownMenuWidget(
          labelText: 'Оценка настроения',
        )),
        Expanded(
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

class SleepRow extends StatelessWidget {
  const SleepRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: DropdownMenuWidget(
            labelText: 'Оценка сна',
          ),
        ),
        Expanded(
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

class FoodRow extends StatelessWidget {
  const FoodRow({super.key});

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

class DropdownMenuWidget extends StatelessWidget {
  final String labelText;

  const DropdownMenuWidget({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          border: OutlineInputBorder(),
        ),
        label: Text(labelText),
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
        ]);
  }
}
