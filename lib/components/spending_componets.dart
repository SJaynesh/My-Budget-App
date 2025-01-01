import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpendingComponents extends StatelessWidget {
  const SpendingComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Spending Page",
        style: TextStyle(
          fontSize: 25.sp,
        ),
      ),
    );
  }
}
