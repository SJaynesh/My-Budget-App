import 'dart:developer';

import 'package:budget_tracker_app/components/all_category_componets.dart';
import 'package:budget_tracker_app/components/all_spending_componets.dart';
import 'package:budget_tracker_app/components/category_components.dart';
import 'package:budget_tracker_app/components/spending_componets.dart';
import 'package:budget_tracker_app/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationController controller = Get.put(NavigationController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Budget Tracker",
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.getNavigationIndex(index: index);
        },
        children: const [
          AllSpendingComponents(),
          SpendingComponents(),
          AllCategoryComponents(),
          CategoryComponents(),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return NavigationBar(
          selectedIndex: controller.navigationIndex.value,
          onDestinationSelected: (index) {
            log("Index : $index");
            controller.getNavigationIndex(index: index);
            controller.changePageView(index: index);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.price_check),
              label: "All Spending",
            ),
            NavigationDestination(
              icon: Icon(Icons.attach_money),
              label: "Spending",
            ),
            NavigationDestination(
              icon: Icon(Icons.receipt_long),
              label: "All Category",
            ),
            NavigationDestination(
              icon: Icon(Icons.category),
              label: "Category",
            ),
          ],
        );
      }),
    );
  }
}
