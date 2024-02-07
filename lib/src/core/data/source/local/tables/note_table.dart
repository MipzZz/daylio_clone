import 'package:daylio_clone/src/features/notes/data/converters/food_model_converter.dart';
import 'package:daylio_clone/src/features/notes/data/converters/mood_model_converter.dart';
import 'package:daylio_clone/src/features/notes/data/converters/sleep_model_converter.dart';
import 'package:drift/drift.dart';

class NoteTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get mood => text().map(const MoodModelConverter()).named('mood')();
  TextColumn get food => text().map(const FoodModelConverter()).named('food').nullable()();
  TextColumn get sleep =>
      text().map(const SleepModelConverter()).named('sleep').nullable()();
  DateTimeColumn get date => dateTime().named('date')();
}
