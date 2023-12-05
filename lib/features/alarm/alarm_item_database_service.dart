import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sbas/util.dart';
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
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        version: 3,
      );
      return true;
    } catch (err) {
      debugPrint("hello");
      debugPrint(err.toString());
      return false;
    }
  }

  FutureOr<void> _onCreate(Database db, int version) {
    String sql = '''
    CREATE TABLE alarm_item(
      title TEXT,
      body TEXT,
      year INTEGER,
      month INTEGER,
      date_time TEXT,
      user_id TEXT,
      received_time TEXT)
    ''';

    db.execute(sql);
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      db.execute('ALTER TABLE alarm_item ADD COLUMN received_time TEXT');
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

  Future<List<AlarmItemModel>> selectAllByUserId() async {
    final Database db = await database;
    var userId = prefs.getString('id');
    final List<Map<String, dynamic>> data = await db.query('alarm_item', where: 'user_id = ?', whereArgs: [userId], orderBy: 'rowId desc');

    var list = List.generate(data.length, (i) {
      return AlarmItemModel(
        title: data[i]['title'],
        body: data[i]['body'],
        year: data[i]['year'],
        month: data[i]['month'],
        dateTime: data[i]['date_time'],
        receivedTime: data[i]['received_time'],
      );
    });

    DateTime now = DateTime.now();
    DateTime thirtyDaysAgo = now.subtract(const Duration(days: 30));

    var recentItems = list.where((item) {
      if (item.receivedTime != null) {
        DateTime itemDateTime = DateTime.parse(item.receivedTime!);
        return itemDateTime.isAfter(thirtyDaysAgo);
      }
      return false;
    }).toList();

    return recentItems;
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
