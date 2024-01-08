// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, unused_import

import 'package:fitness/common/colo_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VioletButton extends StatelessWidget {
  bool isLoading;
  String title;
  final VoidCallback onAction;
  VioletButton(
      {required this.isLoading, required this.title, required this.onAction});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onAction,
      child: Container(
        height: 50.h,
        width: double.infinity,
              decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: TColor.primaryColor1,
      ),
        child: isLoading == false
            ? Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    color: Colors.white,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Please Wait",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Transform.scale(
                    scale: 0.4,
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ],
              ),
      ),
    );
  }
}
