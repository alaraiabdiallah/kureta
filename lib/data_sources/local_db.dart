import 'package:kureta_app/models/savedcategory.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {

  final savedCategoryTable = "saved_category";

  Future<Database> DB() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'kureta.db');
    Database database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
    return database;
  }

  void populateDb(Database database, int version) async {
    print("Create saved_category table");
    await database.execute("CREATE TABLE ${savedCategoryTable}("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "name TEXT"
        ")");
  }
}



class SavedCategorySource extends LocalDB{

  SavedCategorySource(): super();

  getAll() async{
    var db = await DB();
    var result = await db.query(this.savedCategoryTable,columns: ["name"]);
    return result.map((res) => res["name"]).toList();
  }

  Future<int> save(SavedCategory data) async{
    var db = await DB();
    return await db.insert(this.savedCategoryTable, data.toMap());
  }

  saveFromListString(List<String> categories) async{
    List<Future> bulkSave = categories.map((category){
      return save(SavedCategory(name: category));
    }).toList();

    await Future.wait(bulkSave);
  }

  clearAll() async {
    var db = await DB();
    await db.execute("DELETE FROM ${this.savedCategoryTable};");
  }
}