import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../helpers/db_helper.dart';
import '../models/category_model.dart';

class CategoryController extends GetxController {
  int? categoryIndex;
  Future<List<CategoryModel>>? allCategory;

  // Default Constructor
  CategoryController() {
    fetchCategoryData();
  }

  void getCategoryIndex({required int index}) {
    categoryIndex = index;

    update();
  }

  void assignDefaultVal() {
    categoryIndex = null;

    update();
  }

  // Insert Category Record
  Future<void> addCategoryData({
    required String name,
    required Uint8List image,
  }) async {
    int? res = await DBHelper.dbHelper.insertCategory(name: name, image: image);

    if (res != null) {
      Get.snackbar(
        "Insert",
        "$name category is inserted....$res",
        colorText: Colors.white,
        backgroundColor: Colors.green.shade300,
      );
    } else {
      Get.snackbar(
        "Failed",
        "$name category is Insertion failed....",
        colorText: Colors.white,
        backgroundColor: Colors.red.shade300,
      );
    }
  }

  // Fetch Records
  void fetchCategoryData() {
    allCategory = DBHelper.dbHelper.fetchCategory();
  }

  // Live Search
  void searchData({required String val}) {
    allCategory = DBHelper.dbHelper.liveSearchCategory(search: val);

    update();
  }
}
