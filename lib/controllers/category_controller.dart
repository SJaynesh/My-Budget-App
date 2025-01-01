import 'package:get/get.dart';

class CategoryController extends GetxController {
  int? categoryIndex;

  void getCategoryIndex({required int index}) {
    categoryIndex = index;

    update();
  }

  void assignDefaultVal() {
    categoryIndex = null;

    update();
  }
}
