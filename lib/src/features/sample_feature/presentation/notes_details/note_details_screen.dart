import 'package:daylio_clone/src/features/sample_feature/presentation/widgets/mood_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/presentation/assets/res/app_icons.dart';
import '../widgets/date_picker_widget.dart';
import '../widgets/food_row_widget.dart';
import '../widgets/sleep_row_widget.dart';
import '../widgets/time_picker_widget.dart';

class NoteDetailsWidget extends StatefulWidget {
  final int noteId;

  const NoteDetailsWidget({super.key, required this.noteId});

  @override
  State<NoteDetailsWidget> createState() => _NoteDetailsWidgetState();
}

class _NoteDetailsWidgetState extends State<NoteDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.save),
            ),
          )
        ],
        title: Text(widget.noteId.toString()),
      ),
      body:
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              DateNTimeRow(),
              SizedBox(height: 45),
              MoodFacesRow(),
              SizedBox(height: 50),
              MoodDescriptionWidget(),
              SizedBox(height: 50),
              SleepRowWidget(),
              SizedBox(height: 50),
              FoodRowWidget()
            ],
          ),
        )
    );
  }
}

class MoodDescriptionWidget extends StatelessWidget {
  const MoodDescriptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TextField(
      maxLines: 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Описание настроения',
      ),
      style: TextStyle(fontSize: 10),
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

class MoodFacesRow extends StatelessWidget {
  const MoodFacesRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: SvgPicture.asset(AppIcons.funRegular, width: 50, height: 50,)),
        Expanded(child: SvgPicture.asset(AppIcons.goodRegular, width: 50, height: 50,)),
        Expanded(child: SvgPicture.asset(AppIcons.normalRegular, width: 50, height: 50,)),
        Expanded(child: SvgPicture.asset(AppIcons.badRegular, width: 50, height: 50,)),
        Expanded(child: SvgPicture.asset(AppIcons.terribleRegular, width: 50, height: 50,)),
      ],
    );
  }
}




