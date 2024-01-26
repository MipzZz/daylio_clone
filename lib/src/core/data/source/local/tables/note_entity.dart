import 'package:drift/drift.dart';

class NoteTable extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get mood => text().named('mood')();
  TextColumn get food => text().named('food')();
  TextColumn get sleep => text().named('sleep')();
}