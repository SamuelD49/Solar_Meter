import 'dart:io';
import '/model/channal.dart';
import '/services/constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DATABASE_NAME);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $CHANNAL_TABLE_NAME(
          $CHANNAL_COL_ID INTEGER PRIMARY KEY,
          $CHANNAL_COL_NAME TEXT,
          $CHANNAL_COL_TS INTEGER,
          $CHANNAL_COL_VALUE REAL
      )
      ''');
  }

  Future getData({String ch = "ch1", int ts = 0}) async {
    Database db = await instance.database;
    var data = await db.query(CHANNAL_TABLE_NAME,
        where: "$CHANNAL_COL_NAME = ? and $CHANNAL_COL_TS > ? ",
        whereArgs: [ch, ts],
        orderBy: "$CHANNAL_COL_TS DESC");
    return data;
  }

  Future getLastTs() async {
    Database db = await instance.database;
    var ch1 =
        await db.query(CHANNAL_TABLE_NAME, orderBy: "$CHANNAL_COL_TS DESC");
    if (ch1.length > 0) {
      return ch1[0]["ts"];
    } else
      return 0;
  }

  Future add({name = "", ts = 0, value = 0.0}) async {
    Database db = await instance.database;
    return await db.insert(CHANNAL_TABLE_NAME,
        {CHANNAL_COL_NAME: name, CHANNAL_COL_TS: ts, CHANNAL_COL_VALUE: value});
  }

  Future<int> removeAll() async {
    Database db = await instance.database;
    return await db.delete(CHANNAL_TABLE_NAME);
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db
        .delete(CHANNAL_TABLE_NAME, where: 'id = ?', whereArgs: [id]);
  }

  //  Future<int> update(Grocery grocery) async {
//     Database db = await instance.database;
//     return await db.update('groceries', grocery.toMap(),
//         where: "id = ?", whereArgs: [grocery.id]);
//   }
}
