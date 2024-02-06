import 'dart:io';

import 'package:daylio_clone/src/core/data/source/local/tables/note_table.dart';
import 'package:daylio_clone/src/features/notes/data/converters/food_model_converter.dart';
import 'package:daylio_clone/src/features/notes/data/converters/mood_model_converter.dart';
import 'package:daylio_clone/src/features/notes/data/converters/sleep_model_converter.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/food_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/mood_model.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/sleep_model.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'drift_storage.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'note.sqlite'));

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [NoteTable])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  Future<List<NoteTableData>> readNotes() async {
    return await select(noteTable).get();
  }

  Future<int> saveNote(NoteTableCompanion entity) async {
    return await into(noteTable).insert(entity);
  }

  Future<int> deleteNote(int id) async {
    return await (delete(noteTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<NoteTableData> readNote(int id) async {
    return await (select(noteTable)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<bool> updateNote(NoteTableCompanion entity) async {
    return await update(noteTable).replace(entity);
  }

  @override
  int get schemaVersion => 1;
  final isInDebugMode = false;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (openingDetails) async {
        if (isInDebugMode /* or some other flag */) {
          final m = createMigrator(); // changed to this
          for (final table in allTables) {
            await m.deleteTable(table.actualTableName);
            await m.createTable(table);
          }
        }
      },
    );
  }
}
