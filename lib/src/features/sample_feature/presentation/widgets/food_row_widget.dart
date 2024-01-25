import 'package:flutter/material.dart';

import 'dropdown_widget.dart';

class FoodRowWidget extends StatelessWidget {
  const FoodRowWidget({super.key});

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