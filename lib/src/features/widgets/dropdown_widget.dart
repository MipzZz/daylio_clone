import 'package:flutter/material.dart';

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