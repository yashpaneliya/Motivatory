import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database likedb;

class Databasecreator {
  static const liketable = 'LIKED_QUOTES';
  static const id = 'ID';
  static const quoteText = 'QUOTE';
  static const author = 'AUTHOR';
  static const category = 'CATEGORY';

  static void databaselog(String funcname, String sql,
      [List<Map<String, dynamic>> selectQueryResult,
      int insertAndUpdateResult]) {
    print(funcname);
    print(sql);
    if (selectQueryResult != null) {
      print(selectQueryResult);
    } else if (insertAndUpdateResult != null) {
      print(insertAndUpdateResult);
    }
  }

  Future<void> createLikeTable(Database db) async {
    final sql = ''' CREATE TABLE $liketable($id INTEGER PRIMARY KEY,$quoteText TEXT,$author TEXT,$category TEXT)''';
    await db.execute(sql);
  }

  Future<String> getdatabasePath(String dbname) async {
    final databasepath = await getDatabasesPath();
    final path = join(databasepath, dbname);
    if (await Directory(dirname(path)).exists()) {
      //await deletedatbase();
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {
    final path = await getdatabasePath('like_db');
    likedb = await openDatabase(path, version: 1, onCreate: oncreate);
    print(likedb);
  }

  Future<void> oncreate(Database db, int version) async {
    await createLikeTable(db);
  }
}