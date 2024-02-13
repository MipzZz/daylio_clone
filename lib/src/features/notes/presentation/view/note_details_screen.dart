import 'package:daylio_clone/src/core/presentation/assets/buttons/app_button_style.dart';
import 'package:daylio_clone/src/core/utils/extensions/date_time_extension.dart';
import 'package:daylio_clone/src/core/utils/extensions/time_of_day_extension.dart';
import 'package:daylio_clone/src/features/notes/data/repository/notes_repository.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/grade_label.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/moods_storage.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_details_bloc/note_details_events.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_details_bloc/note_details_state.dart';
import 'package:daylio_clone/src/features/notes/domain/bloc/notes_details_bloc/notes_details_bloc.dart';
import 'package:daylio_clone/src/features/notes/presentation/widgets/alert_failure_dialog_widget.dart';
import 'package:daylio_clone/src/features/notes/presentation/widgets/mood_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocProvider(
        create: (context) => NotesDetailsBloc(
              notesRepository: context.read<NotesRepository>(),
            )..add(NoteDetailsLoadNoteEvent(widget.noteId)),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              actions: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: _SaveButton(),
                )
              ],
              title: Text('Запись от ${widget.noteId}'),
            ),
            body: BlocBuilder<NotesDetailsBloc, NoteDetailsState>(
              //Можно ли использовать BlocListen?
              buildWhen: (prev, curr) => prev.runtimeType != curr.runtimeType,
              //ToDO спросить обязательно ли использовать runtimeType
              builder: (context, state) {
                return switch (state) {
                  NoteDetailsStateInitial() => const Text('Инициализация'),
                  NoteDetailsStateError(message: final message) =>
                    AlertFailureDialogWidget(message: message),
                  _ => const _DefaultBodyWidget(),
                };
              },
            ),
          ),
        ));
  }
}

class _DefaultBodyWidget extends StatelessWidget {
  const _DefaultBodyWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: const [
          _DateNTimeRow(),
          SizedBox(height: 45),
          _MoodFacesRow(),
          SizedBox(height: 50),
          _SleepRowWidget(),
          SizedBox(height: 50),
          _FoodRowWidget(),
          SizedBox(height: 30),
          _DeleteButton(),
        ],
      ),
    );
  }
}

class _DateNTimeRow extends StatelessWidget {
  const _DateNTimeRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: _DatePickerWidget()),
        Expanded(child: _TimePickerWidget()),
      ],
    );
  }
}

class _DatePickerWidget extends StatefulWidget {
  const _DatePickerWidget();

  @override
  State<_DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<_DatePickerWidget> {
  void _updateDate(DateTime date) {
    context.read<NotesDetailsBloc>().add(NoteDetailsDateChangeEvent(date));
  }

  void selectDate(DateTime? selectedDate) async {
    if (selectedDate == null) {
      return;
    }
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
      builder: (context, child) {
        if (child == null) {
          return const SizedBox(
            child: Text('Непердвиденная ошибка'),
          );
        }
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  onSurface: Colors.white,
                ),
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        foregroundColor:
                            const Color.fromARGB(255, 180, 135, 218)))),
            child: child);
      },
    );
    if (date != null) {
      _updateDate(date);
    }
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<NotesDetailsBloc, NoteDetailsState>(
        builder: (context, state) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              state.date.dateOnly(),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              style: AppButtonStyle.buttonDateTimeStyle,
              onPressed: () => selectDate(state.date),
              child: const Text(
                'Выбрать дату',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      );
}

class _TimePickerWidget extends StatefulWidget {
  const _TimePickerWidget();

  @override
  State<_TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<_TimePickerWidget> {
  void setTime(TimeOfDay selectedTime) async {
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
        context.read<NotesDetailsBloc>().add(
              NoteDetailsTimeChangeEvent(timeOfDay),
            );
        selectedTime = timeOfDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TimeOfDay selectedTime =
        TimeOfDay.fromDateTime(context.watch<NotesDetailsBloc>().state.date);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          selectedTime.timeOnly(),
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          style: AppButtonStyle.buttonDateTimeStyle,
          onPressed: () => setTime(selectedTime),
          child: const Text(
            'Выбрать время',
            style: TextStyle(fontSize: 12),
          ),
        )
      ],
    );
  }
}

class _MoodFacesRow extends StatefulWidget {
  const _MoodFacesRow();

  @override
  State<_MoodFacesRow> createState() => _MoodFacesRowState();
}

class _MoodFacesRowState extends State<_MoodFacesRow> {
  void selectMood(int moodId) {
    context.read<NotesDetailsBloc>().add(NoteDetailsMoodChangeEvent(moodId));
  }

  @override
  Widget build(BuildContext context) {
    final noteDetailsVM = context.watch<NotesDetailsBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        5,
        (index) {
          final mood = MoodsStorage.values[index];
          return MoodIcon(
            iconPath: mood.selectedIcon,
            unselectedPath: mood.unSelectedIcon,
            onTap: () => selectMood(index),
            selected: mood.id == noteDetailsVM.state.moodId,
          );
        },
      ),
    );
  }
}

class _SleepRowWidget extends StatefulWidget {
  const _SleepRowWidget();

  @override
  State<_SleepRowWidget> createState() => _SleepRowWidgetState();
}

class _SleepRowWidgetState extends State<_SleepRowWidget> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    final initialSleepDescription =
        context.read<NotesDetailsBloc>().state.sleepDescription;
    _textController = TextEditingController(text: initialSleepDescription);
  }

  void _onSleepSelect(GradeLabel? gradeLabel) {
    if (gradeLabel == null) return;
    context
        .read<NotesDetailsBloc>()
        .add(NoteDetailsSleepChangeGradeEvent(gradeLabel.index));
  }

  void _onSleepDescriptionChanged(String v) {
    context
        .read<NotesDetailsBloc>()
        .add(NoteDetailsSleepChangeDescriptionEvent(v));
  }

  @override
  Widget build(BuildContext context) {
    final noteDetailsState = context.watch<NotesDetailsBloc>().state;
    GradeLabel? initSelect =
        GradeLabel.values.elementAtOrNull(noteDetailsState.sleepId);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: DropdownMenu<GradeLabel>(
            initialSelection: initSelect,
            onSelected: _onSleepSelect,
            label: const Text('Оценка сна'),
            inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              border: OutlineInputBorder(),
            ),
            textStyle: const TextStyle(fontSize: 15),
            dropdownMenuEntries: GradeLabel.values
                .map<DropdownMenuEntry<GradeLabel>>((GradeLabel grade) {
              return DropdownMenuEntry<GradeLabel>(
                value: grade,
                label: grade.title,
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: TextField(
            controller: _textController,
            onChanged: _onSleepDescriptionChanged,
            maxLines: 1,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Описание сна',
            ),
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}

class _FoodRowWidget extends StatefulWidget {
  const _FoodRowWidget();

  @override
  State<_FoodRowWidget> createState() => _FoodRowWidgetState();
}

class _FoodRowWidgetState extends State<_FoodRowWidget> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    final initialFoodDescription =
        context.read<NotesDetailsBloc>().state.foodDescription;
    _textController = TextEditingController(text: initialFoodDescription);
  }

  void _onFoodSelect(GradeLabel? gradeLabel) {
    if (gradeLabel == null) return;
    context
        .read<NotesDetailsBloc>()
        .add(NoteDetailsFoodChangeGradeEvent(gradeLabel.index));
  }

  void _onFoodDescriptionChanged(String v) {
    context
        .read<NotesDetailsBloc>()
        .add(NoteDetailsFoodChangeDescriptionEvent(v));
  }

  @override
  Widget build(BuildContext context) {
    final noteDetailsState = context.watch<NotesDetailsBloc>().state;
    GradeLabel? initSelect = GradeLabel.values[noteDetailsState.foodId];
    GradeLabel.values.elementAtOrNull(noteDetailsState.foodId);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: DropdownMenu<GradeLabel>(
            initialSelection: initSelect,
            onSelected: _onFoodSelect,
            label: const Text('Оценка еды'),
            inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              border: OutlineInputBorder(),
            ),
            textStyle: const TextStyle(fontSize: 15),
            dropdownMenuEntries:
                GradeLabel.values.map<DropdownMenuEntry<GradeLabel>>(
              (GradeLabel grade) {
                return DropdownMenuEntry<GradeLabel>(
                  value: grade,
                  label: grade.title,
                );
              },
            ).toList(),
          ),
        ),
        Expanded(
          child: TextField(
            controller: _textController,
            onChanged: _onFoodDescriptionChanged,
            maxLines: 1,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Описание еды',
            ),
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton();

  void _onDeleteButton(BuildContext context) {
    context.read<NotesDetailsBloc>().add(const NoteDetailsDeleteEvent());
    if (!context.mounted) return;
    switch (context.read<NotesDetailsBloc>().state) {
      case NoteDetailsStateError(message: final message):
        showDialog(
          context: context,
          builder: (_) {
            return AlertFailureDialogWidget(
              message: message,
            );
          },
        );
      default:
        Navigator.popUntil(context, ModalRoute.withName('/'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: OutlinedButton(
        style: AppButtonStyle.deleteNoteButtonStyle,
        onPressed: () => _onDeleteButton(context),
        child: const Text('Удалить запись', style: TextStyle(fontSize: 15)),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton();

  void _onSaveButton(BuildContext context) {
    context.read<NotesDetailsBloc>().add(const NoteDetailsSaveEvent());
    if (!context.mounted) return;
    switch (context.read<NotesDetailsBloc>().state) {
      case NoteDetailsStateError(message: final message):
        showDialog(
          context: context,
          builder: (_) {
            return AlertFailureDialogWidget(
              message: message,
            );
          },
        );
      default:
        Navigator.popUntil(context, ModalRoute.withName('/'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _onSaveButton(context),
      icon: const Icon(Icons.save),
    );
  }
}
