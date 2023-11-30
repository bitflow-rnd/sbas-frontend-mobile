import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/alarm_item_model.dart';

class AlarmItemDatabaseService {
  static final AlarmItemDatabaseService _database = AlarmItemDatabaseService._internal();

  late Future<Database> database;

  factory AlarmItemDatabaseService() => _database;

  AlarmItemDatabaseService._internal() {
    databaseConfig();
  }

  Future<bool> databaseConfig() async {
    try {
      database = openDatabase(
        join(await getDatabasesPath(), 'sbas_database.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE alarm_item(title TEXT, body TEXT, year INTEGER, month INTEGER, date_time TEXT)',
          );
        },
        version: 1,
      );
      return true;
    } catch (err) {
      debugPrint("hello");
      debugPrint(err.toString());
      return false;
    }
  }

  Future<bool> insert(AlarmItemModel alarmItemModel) async {
    final Database db = await database;

    try {
      db.insert(
        'alarm_item',
        alarmItemModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return true;
    } catch (err) {
      debugPrint(err.toString());
      return false;
    }
  }

  Future<List<AlarmItemModel>> select() async {
    final Database db = await database;

    final List<Map<String, dynamic>> data = await db.query('alarm_item', orderBy: 'rowId desc');

    return List.generate(data.length, (i) {
      return AlarmItemModel(
        title: data[i]['title'],
        body: data[i]['body'],
        year: data[i]['year'],
        month: data[i]['month'],
        dateTime: data[i]['date_time'],
      );
    });
  }

  Future<AlarmItemModel> selectById(int id) async {
    final Database db = await database;

    final List<Map<String, dynamic>> data =
        await db.query('alarm_item', where: 'rowId = ?', whereArgs: [id]);

    return AlarmItemModel(
      title: data[0]['title'],
      body: data[0]['body'],
      year: data[0]['year'],
      month: data[0]['month'],
      dateTime: data[0]['date_time'],
    );
  }

  Future<bool> delete(int id) async {
    final Database db = await database;

    try {
      db.delete(
        'alarm_item',
        where: 'rowId = ?',
        whereArgs: [id],
      );

      return true;
    } catch (err) {
      return false;
    }
  }
}
