import 'dart:async';

import 'package:budget_tracker_app/get_pages/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(
        seconds: 3,
      ),
      () {
        Get.offNamed(GetPages.home);
      },
    );
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Image.network(
            'https://w7.pngwing.com/pngs/890/998/png-transparent-expense-management-appbrain-deloitte-luxembourg-expense-grass-revenue-money-thumbnail.png',
            height: 100.h,
          ),
          const Spacer(),
          const LinearProgressIndicator(
            color: Color(0xff4bae4f),
          ),
        ],
      ),
    );
  }
}
