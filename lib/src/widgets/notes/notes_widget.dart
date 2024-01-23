import 'package:daylio_clone/src/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Note {
  final int id;
  final String mood;
  final String sleep;
  final String food;
  final String date;

  Note({
    required this.id,
    required this.mood,
    required this.sleep,
    required this.food,
    required this.date,
  });
}

class NotesWidget extends StatefulWidget {
  const NotesWidget({super.key});

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  final _notes = [
    Note(
      id: 1,
      mood: 'Good',
      sleep: '3',
      food: '2',
      date: '2022-01-01',
    ),
    Note(
      id: 2,
      mood: 'Good',
      sleep: '4',
      food: '7',
      date: '2022-01-01',
    ),
    Note(
      id: 2,
      mood: 'Good',
      sleep: '8',
      food: '8',
      date: '2022-01-01',
    ),
    Note(
      id: 2,
      mood: 'Good',
      sleep: '8',
      food: '9',
      date: '2022-01-01',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 70),
          itemCount: _notes.length,
          itemBuilder: (BuildContext context, int index) {
            final _note = _notes[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.listBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: index == 0
                            ? const Radius.circular(20.0)
                            : Radius.zero,
                        topRight: index == 0
                            ? const Radius.circular(20.0)
                            : Radius.zero,
                        bottomLeft: index == _notes.length - 1
                            ? const Radius.circular(20.0)
                            : Radius.zero,
                        bottomRight: index == _notes.length - 1
                            ? const Radius.circular(20.0)
                            : Radius.zero,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.face,
                              size: 70, color: AppColors.mainGreen),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    _note.mood,
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontSize: 20
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(_note.date),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.bed,
                                      color: AppColors.mainGreen),
                                  Text(_note.sleep),
                                  const SizedBox(width: 10),
                                  const Icon(Icons.emoji_food_beverage,
                                      color: AppColors.mainGreen),
                                  Text(_note.food),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
