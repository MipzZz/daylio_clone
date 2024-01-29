
import 'package:daylio_clone/src/core/presentation/assets/res/app_icons.dart';
import 'package:daylio_clone/src/features/notes_list/data/repository/notes_repository.dart';
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
      create: (context) => NotesDetailsProvider(notesRepository: notesRepository, id: id),
      child: Scaffold(
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
        final id = context.read<int>();
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
    final moodController = TextEditingController(text: context.watch<NotesDetailsProvider>().state.note.mood);
    return TextField(
      controller: moodController,
      maxLines: 1,
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
        Expanded(child: DatePickerWidget()),
        Expanded(child: TimePickerWidget()),
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
          child: SvgPicture.asset(
            AppIcons.funRegular,
            width: 50,
            height: 50,
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
