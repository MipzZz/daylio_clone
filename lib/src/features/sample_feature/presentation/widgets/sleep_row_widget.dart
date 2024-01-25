import 'package:flutter/material.dart';

import 'dropdown_widget.dart';

class SleepRowWidget extends StatelessWidget {
  const SleepRowWidget({
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