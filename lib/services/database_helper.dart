import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wellness/model/countries_model.dart';

class DatabaseHelper {
  final String tableWords = 'favCountryList';
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableWords (
                abbriviation TEXT PRIMARY KEY,
                country TEXT NOT NULL,
                region TEXT NOT NULL
              )
              ''');
  }

  Future<int> insert(Countries countries) async {
    Database db = await database;
    int id = await db.insert(tableWords, countries.toMap());
    return id;
  }

  Future<int> delete(Countries countries) async {
    Database db = await database;
    int id = await db.rawDelete(
        'DELETE FROM $tableWords WHERE abbriviation = ?',[countries.abbriviation]);
    return id;
  }

  Future<List<Countries>> queryAllCountries() async {
    List<Countries> list = [];
    Database db = await database;
    List<Map> maps = await db.query(tableWords);
    if (maps.length > 0) {
      print("fetched data from db$maps");
      maps.forEach((Map element) {
        Countries _countries = Countries(
          abbriviation: element['abbriviation'],
          countryDetail:
              Country(country: element['country'], region: element['region']),
        );
        list.add(_countries);
      });
      return list;
    }
    return null;
  }
}
