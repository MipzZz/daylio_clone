import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/features/sample_feature/presentation/widgets/food_row_widget.dart';
import 'package:daylio_clone/src/features/sample_feature/presentation/widgets/mood_row_widget.dart';
import 'package:daylio_clone/src/features/sample_feature/presentation/widgets/sleep_row_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/date_picker_widget.dart';
import '../widgets/time_picker_widget.dart';

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
            MoodRowWidget(),
            SizedBox(height: 50),
            SleepRowWidget(),
            SizedBox(height: 50),
            FoodRowWidget(),
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