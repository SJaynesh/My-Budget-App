import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // Private Named Constructor
  DBHelper._();

  // Singleton Object
  static DBHelper dbHelper = DBHelper._();

  static Logger logger = Logger();

  Database? db;

  String categoryTable = "category";
  String categoryName = "category_name";
  String categoryImage = "category_image";

  // TODO: Create a DATABASE
  Future<void> initDB() async {
    String dbPath = await getDatabasesPath();

    String path = "${dbPath}budget.db";

    // TODO: Create a TABLES

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, _) async {
        String query = '''CREATE TABLE $categoryTable(
            category_id INTEGER PRIMARY KEY AUTOINCREMENT,
            $categoryName TEXT NOT NULL,
            $categoryImage BLOB NOT NULL
        );''';

        await db.execute(query).then(
          (value) {
            logger.i("Student table is created....");
          },
        ).onError(
          (error, _) {
            logger.e("Student table is not creation...", error: error);
          },
        );
      },
    );
  }

  // TODO: INSERT RECORDS
  Future<int?> insertCategory({
    required String name,
    required Uint8List image,
  }) async {
    await initDB();

    // Query Parameters = ?

    // C Language  int a = 25;  printf("%d",a);

    String query =
        "INSERT INTO $categoryTable ($categoryName, $categoryImage) VALUES(?, ?);";

    List arg = [name, image];

    return await db?.rawInsert(query, arg);
  }

  // TODO: FETCH ALL RECORDS
  Future<void> fetchCategory() async {
    await initDB();
  }

  // TODO: UPDATE RECORD
  Future<void> updateCategory() async {
    await initDB();
  }

  // TODO: DELETE RECORD
  Future<void> deleteCategory() async {
    await initDB();
  }
}
