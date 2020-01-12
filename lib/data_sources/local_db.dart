import 'package:kureta_app/models/article.dart';
import 'package:kureta_app/models/savedcategory.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {

  final savedCategoryTable = "saved_category";
  final bookmarkTable = "bookmark";

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
    await database.execute("CREATE TABLE ${bookmarkTable}("
        "id TEXT PRIMARY KEY ,"
        "title TEXT,"
        "category TEXT,"
        "excerpt TEXT,"
        "content TEXT,"
        "imageURL TEXT"
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

class BookmarkSource extends LocalDB{
  BookmarkSource(): super();

  Future<List<Article>> getAll() async{
    var db = await DB();
    var result = await db.query(this.bookmarkTable);
    return result.map((res) => Article.fromLocalDB(res)).toList();
  }

  Future<bool> toggle(Article data) async{
    try{
      var db = await DB();
      var getData = await db.query(this.bookmarkTable, where: "id = ?",whereArgs: [data.id]);
      if(getData.length > 0)
        await db.delete(this.bookmarkTable,where: "id = ?",whereArgs: [data.id]);
      else
        await db.insert(this.bookmarkTable, data.toMap());
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }
  }

  Future<bool> isBookmarked(String id) async{
    try{
      var db = await DB();
      var getData = await db.query(this.bookmarkTable,where: "id = ?",whereArgs: [id]);
      return getData.length > 0;
    }catch(e){
      print(e.toString());
      return false;
    }
  }
}