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
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DateNTimeRow(),
            SizedBox(height: 50),
            MoodRow(),
            SizedBox(height: 50),
            SleepRow(),
            SizedBox(height: 50),
            FoodRow(),
          ],
        ),
      ),
    );
  }
}

class FoodRow extends StatelessWidget {
   const FoodRow({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            DropdownMenu(
              width: 157,
              inputDecorationTheme: InputDecorationTheme(
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                border: OutlineInputBorder(),
              ),
              label: Text('Оценка еды'),
              textStyle: TextStyle(fontSize: 15),
                dropdownMenuEntries: [
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
                ]
            ),
          ],
        ),

        Spacer(),
        SizedBox(
          width: 200,
          height: 50,
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

class SleepRow extends StatelessWidget {
  const SleepRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Сон'),
        Spacer(),
        SizedBox(
          width: 200,
          height: 50,
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

class MoodRow extends StatelessWidget {
  const MoodRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Настроение'),
        Spacer(),
        SizedBox(
          width: 200,
          height: 50,
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

class DateNTimeRow extends StatelessWidget {
  const DateNTimeRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Дата'),
        Spacer(),
        Text('Время'),
      ],
    );
  }
}
