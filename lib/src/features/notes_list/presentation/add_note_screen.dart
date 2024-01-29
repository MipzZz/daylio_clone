import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/features/widgets/date_picker_widget.dart';
import 'package:daylio_clone/src/features/widgets/food_row_widget.dart';
import 'package:daylio_clone/src/features/widgets/mood_row_widget.dart';
import 'package:daylio_clone/src/features/widgets/sleep_row_widget.dart';
import 'package:daylio_clone/src/features/widgets/time_picker_widget.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DateNTimeRow(),
            const SizedBox(height: 30),
            const MoodRowWidget(),
            const SizedBox(height: 50),
            const SleepRowWidget(),
            const SizedBox(height: 50),
            const FoodRowWidget(),
            const SizedBox(height: 50),
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