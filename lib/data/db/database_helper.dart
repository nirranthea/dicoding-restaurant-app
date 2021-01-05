import 'package:restaurant_app/data/model/response.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createObject();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createObject();
    }
    return _databaseHelper;
  }

  static const String _tblBookmark = 'bookmarks';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurantapp.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblBookmark (
                          id TEXT PRIMARY KEY,
                          name TEXT,
                          description TEXT,
                          pictureId TEXT,
                          city TEXT,
                          rating NUMBER
                          )
                         ''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }
    return _database;
  }

  Future<void> insertBookmark(Resto resto) async {
    final db = await database;
    await db.insert(_tblBookmark, resto.toJson());
  }

  Future<List<Resto>> getBookmarks() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(_tblBookmark);
    return results.map((res) => Resto.fromJson(res)).toList();
  }

  Future<Map> getBookmarkById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tblBookmark, where: 'id = ?', whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeBookmark(String id) async {
    final db = await database;
    await db.delete(_tblBookmark, where: 'id = ?', whereArgs: [id],
    );
  }
}