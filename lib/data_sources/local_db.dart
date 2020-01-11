import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initDatabase() async {
  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'kureta.db');
  print("Init DB");
  Database database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
  return database;
}

void populateDb(Database database, int version) async {
  print("Create saved_category table");
  await database.execute("CREATE TABLE saved_category ("
      "id INTEGER PRIMARY KEY,"
      "name TEXT"
      ")");
}

final Future<Database> sqlite = initDatabase();