import 'package:budget_tracker_app/models/category_model.dart';
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
  String categoryImageIndex = "category_image_index";

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
            $categoryImage BLOB NOT NULL,
            $categoryImageIndex INTEGER NOT NULL
        );''';

        await db.execute(query).then(
          (value) {
            logger.i("$categoryTable table is created....");
          },
        ).onError(
          (error, _) {
            logger.e("$categoryTable table is not creation...", error: error);
          },
        );
      },
    );
  }

  // TODO: INSERT RECORDS
  Future<int?> insertCategory({
    required String name,
    required Uint8List image,
    required int index,
  }) async {
    await initDB();

    // Query Parameters = ?

    // C Language  int a = 25;  printf("%d",a);

    String query =
        "INSERT INTO $categoryTable ($categoryName, $categoryImage,$categoryImageIndex) VALUES(?, ?, ?);";

    List arg = [name, image, index];

    return await db?.rawInsert(query, arg);
  }

  // TODO: FETCH ALL RECORDS
  Future<List<CategoryModel>> fetchCategory() async {
    await initDB();

    String query = "SELECT * FROM $categoryTable;";

    List<Map<String, dynamic>> res = await db?.rawQuery(query) ?? [];

    return res
        .map(
          (e) => CategoryModel.fromMap(data: e),
        )
        .toList();
  }

  Future<List<CategoryModel>> liveSearchCategory({
    required String search,
  }) async {
    await initDB();

    String query =
        "SELECT * FROM $categoryTable WHERE $categoryName LIKE '%$search%';";

    List<Map<String, dynamic>> res = await db?.rawQuery(query) ?? [];

    return res
        .map(
          (e) => CategoryModel.fromMap(data: e),
        )
        .toList();
  }

  // TODO: UPDATE RECORD
  Future<int?> updateCategory({required CategoryModel model}) async {
    await initDB();

    String query =
        "UPDATE $categoryTable SET $categoryName = ?, $categoryImage = ?, $categoryImageIndex = ? WHERE category_id = ${model.id};";
    List arg = [
      model.name,
      model.image,
      model.index,
    ];
    return await db?.rawUpdate(query, arg);
  }

  // TODO: DELETE RECORD
  Future<int?> deleteCategory({required int id}) async {
    await initDB();

    String query = "DELETE FROM $categoryTable WHERE category_id=$id;";

    return await db?.rawDelete(query);
  }
}
