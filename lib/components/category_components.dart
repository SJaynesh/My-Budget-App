import 'package:budget_tracker_app/controllers/category_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

List<String> categoryImages = [
  "assets/images/bill.png",
  "assets/images/cash.png",
  "assets/images/communication.png",
  "assets/images/deposit.png",
  "assets/images/food.png",
  "assets/images/gift.png",
  "assets/images/health.png",
  "assets/images/movie.png",
  "assets/images/rupee.png",
  "assets/images/salary.png",
  "assets/images/shopping.png",
  "assets/images/transport.png",
  "assets/images/wallet.png",
  "assets/images/withdraw.png",
  "assets/images/other.png",
];
GlobalKey<FormState> categoryKey = GlobalKey<FormState>();
TextEditingController categoryNameController = TextEditingController();

class CategoryComponents extends StatelessWidget {
  const CategoryComponents({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryController controller = Get.put(CategoryController());
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: categoryKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choice Category !!",
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            TextFormField(
              controller: categoryNameController,
              validator: (val) =>
                  val!.isEmpty ? "Required category name" : null,
              decoration: InputDecoration(
                labelText: "Category",
                hintText: "Enter you category",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.deepPurpleAccent,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.redAccent,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemCount: categoryImages.length,
                itemBuilder: (ctx, index) =>
                    GetBuilder<CategoryController>(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      controller.getCategoryIndex(index: index);

                      // categoryIndex = 2
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: (controller.categoryIndex == index)
                              ? Colors.grey
                              : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(
                            categoryImages[index],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton.extended(
                  onPressed: () async {
                    if (categoryKey.currentState!.validate() &&
                        controller.categoryIndex != null) {
                      String name = categoryNameController.text;

                      // assetImage = ByteData = Uint8List

                      String assetPath =
                          categoryImages[controller.categoryIndex!];

                      ByteData byteData = await rootBundle.load(assetPath);

                      Uint8List image = byteData.buffer.asUint8List();

                      controller.addCategoryData(name: name, image: image);
                    } else {
                      Get.snackbar(
                        "Required",
                        "category name and image are required..",
                        colorText: Colors.white,
                        backgroundColor: Colors.redAccent,
                      );
                    }

                    categoryNameController.clear();
                    controller.assignDefaultVal();
                  },
                  icon: const Icon(CupertinoIcons.add_circled),
                  label: const Text("Add Category"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
