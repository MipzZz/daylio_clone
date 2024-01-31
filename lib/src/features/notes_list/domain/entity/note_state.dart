import 'package:daylio_clone/src/core/presentation/assets/res/app_icons.dart';
import 'package:daylio_clone/src/features/notes_list/domain/entity/mood_model.dart';
import 'package:daylio_clone/src/features/notes_list/domain/entity/note_model.dart';
import 'package:flutter/material.dart';

class NoteState {
  final NoteModel note;
  final List<MoodModel> moods = [
    MoodModel(
        id: 0,
        title: 'Отлично',
        icon: {
          'selected': AppIcons.excellentSolid,
          'notSelected': AppIcons.excellentRegular
        },
        color: Colors.green),
    MoodModel(
        id: 1,
        title: 'Хорошо',
        icon: {
          'selected': AppIcons.goodSolid,
          'notSelected': AppIcons.goodRegular
        },
        color: Colors.green),
    MoodModel(
        id: 2,
        title: 'Нормально',
        icon: {
          'selected': AppIcons.normalSolid,
          'notSelected': AppIcons.normalRegular
        },
        color: Colors.green),
    MoodModel(
        id: 3,
        title: 'Плохо',
        icon: {
          'selected': AppIcons.badSolid,
          'notSelected': AppIcons.badRegular
        },
        color: Colors.green),
    MoodModel(
        id: 4,
        title: 'Ужасно',
        icon: {
          'selected': AppIcons.terribleSolid,
          'notSelected': AppIcons.terribleRegular
        },
        color: Colors.green),
  ];
  final int activeMoodId;

  NoteState({required this.note, required this.activeMoodId});

  NoteState copyWith({
    NoteModel? note,
    int? activeMoodId,
  }) {
    return NoteState(
      note: note ?? this.note,
      activeMoodId: activeMoodId ?? this.activeMoodId,
    );
  }
}