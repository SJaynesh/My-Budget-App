import 'dart:developer';

import 'package:budget_tracker_app/components/category_components.dart';
import 'package:budget_tracker_app/controllers/category_controller.dart';
import 'package:budget_tracker_app/models/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AllCategoryComponents extends StatelessWidget {
  const AllCategoryComponents({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryController controller = Get.put(CategoryController());
    controller.fetchCategoryData();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            onChanged: (val) async {
              log("DATA : $val");
              controller.searchData(val: val);
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(CupertinoIcons.search),
              hintText: "Search",
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: GetBuilder<CategoryController>(builder: (context) {
              return FutureBuilder(
                future: controller.allCategory,
                builder: (context, snapShot) {
                  if (snapShot.hasError) {
                    return Center(
                      child: Text("ERROR : ${snapShot.error}"),
                    );
                  } else if (snapShot.hasData) {
                    List<CategoryModel> allCategoryData = snapShot.data ?? [];

                    return (allCategoryData.isNotEmpty)
                        ? ListView.builder(
                            itemCount: allCategoryData.length,
                            itemBuilder: (context, index) {
                              CategoryModel data = CategoryModel(
                                id: allCategoryData[index].id,
                                name: allCategoryData[index].name,
                                image: allCategoryData[index].image,
                                index: allCategoryData[index].index,
                              );
                              return Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 26.w,
                                    backgroundImage: MemoryImage(data.image),
                                  ),
                                  title: Text(data.name),
                                  trailing: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          categoryNameController.text =
                                              data.name;

                                          controller.assignDefaultVal();

                                          Get.bottomSheet(
                                            Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(16),
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                              ),
                                              child: Form(
                                                key: categoryKey,
                                                child: Column(
                                                  children: [
                                                    const Text(
                                                      "Update Category",
                                                      style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          categoryNameController,
                                                      validator: (val) =>
                                                          val!.isEmpty
                                                              ? "Required..."
                                                              : null,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: "Category",
                                                        hintText:
                                                            "Enter category...",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                borderSide:
                                                                    const BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                )),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                borderSide:
                                                                    const BorderSide(
                                                                  color: Colors
                                                                      .deepPurpleAccent,
                                                                )),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                borderSide:
                                                                    const BorderSide(
                                                                  color: Colors
                                                                      .redAccent,
                                                                )),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                borderSide:
                                                                    const BorderSide(
                                                                  color: Colors
                                                                      .redAccent,
                                                                )),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Expanded(
                                                      child: GridView.builder(
                                                        gridDelegate:
                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 5,
                                                        ),
                                                        itemCount:
                                                            categoryImages
                                                                .length,
                                                        itemBuilder: (context,
                                                                index) =>
                                                            GetBuilder<
                                                                    CategoryController>(
                                                                builder:
                                                                    (context) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              controller
                                                                  .getCategoryIndex(
                                                                      index:
                                                                          index);
                                                            },
                                                            child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(3),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                border:
                                                                    Border.all(
                                                                  color: (controller
                                                                              .categoryIndex !=
                                                                          null)
                                                                      ? (controller.categoryIndex ==
                                                                              index)
                                                                          ? Colors
                                                                              .grey
                                                                          : Colors
                                                                              .transparent
                                                                      : (index ==
                                                                              data
                                                                                  .index)
                                                                          ? Colors
                                                                              .grey
                                                                          : Colors
                                                                              .transparent,
                                                                ),
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      AssetImage(
                                                                    categoryImages[
                                                                        index],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                      ),
                                                    ),
                                                    FloatingActionButton
                                                        .extended(
                                                      onPressed: () async {
                                                        if (categoryKey
                                                                .currentState!
                                                                .validate() &&
                                                            controller
                                                                    .categoryIndex !=
                                                                null) {
                                                          String name =
                                                              categoryNameController
                                                                  .text;

                                                          String assetPath =
                                                              categoryImages[
                                                                  controller
                                                                      .categoryIndex!];

                                                          ByteData byteData =
                                                              await rootBundle
                                                                  .load(
                                                                      assetPath);

                                                          Uint8List image =
                                                              byteData.buffer
                                                                  .asUint8List();

                                                          CategoryModel model =
                                                              CategoryModel(
                                                            id: data.id,
                                                            name: name,
                                                            image: image,
                                                            index: controller
                                                                .categoryIndex!,
                                                          );

                                                          controller
                                                              .updateCategoryData(
                                                                  model: model);

                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      },
                                                      label: const Text(
                                                        "Update Category",
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          controller.deleteCategory(
                                              id: data.id);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                        : const Center(
                            child: Text("No Category Available"),
                          );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
