import 'dart:io';

import 'package:daylio_clone/src/core/data/source/local/tables/note_entity.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;


part 'drift_storage.g.dart';

LazyDatabase _openConnection(){
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'note.sqlite'));

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [NoteTable])
class AppDb extends _$AppDb{
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;


  Future<List<NoteTableData>> readNotes() async {
    return await select(noteTable).get();
  }

  Future<int> saveNote(NoteTableCompanion entity) async {
    return await into(noteTable).insert(entity);
  }
}