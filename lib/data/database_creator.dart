import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database db;

class Quotes{
  static const quoteTable = 'Quotes';
  static const id='id';
  static const quoteText='QuoteText';
  static const author='Author';
  static const liked='Liked';
  static const category='Category';

  static void databaseLog(String functionName,String sql,List<Map<String,dynamic>> selectQueryResult,int insertAndUpdateQueryResult){
    print(functionName);
    print(sql);
    if(selectQueryResult!=null){
      print(selectQueryResult);
    }
    else if (insertAndUpdateQueryResult!=null){
      print(insertAndUpdateQueryResult);
    }
  }

  //to create database table
  Future<void> createQuoteTable(Database db)async{
    final quoteSql='''CREATE TABLE $quoteTable(
      $id INTEGER PRIMARY KEY,
      $quoteText TEXT,
      $author TEXT,
      $liked NUMBER(1),
      $category TEXT,
    )''';

    await db.execute(quoteSql);
  }

  Future<String> getDatabasePath(String dbname)async{
    final databasepath=await getDatabasesPath();
    final path=join(databasepath,dbname);

    if(await Directory(dirname(path)).exists()){
      // await deleteDatabase(path);

    }else{
      await Directory(dirname(path)).create(recursive:true);
    }
    return path;
  }

  //
  Future<void> initdatabase()async{
    final path=await getDatabasePath('quotes_db');
    db=await openDatabase(path,version: 1,onCreate: onCreate);
print(db);
  }

  Future<void> onCreate(Database db,int vrsion)async{

  }
}