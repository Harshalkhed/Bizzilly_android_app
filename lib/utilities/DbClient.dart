import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//sqflite Database client for storing local data

class DbClient {
  getDatabaseConnection() async {
    //check if flutter has initialized its widgets
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'cache.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE cache(data TEXT, ctx TEXT)",
        );
      },
      version: 1,
    );
    return database;
  }
}
