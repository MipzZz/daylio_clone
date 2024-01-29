import 'package:daylio_clone/src/features/widgets/dropdown_widget.dart';
import 'package:flutter/material.dart';



class MoodRowWidget extends StatelessWidget {
  const MoodRowWidget({
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