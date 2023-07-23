import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/app_colors.dart';
import '../styles/text_styles.dart';

abstract class CustomeSnackBar {
  static void showSnackBar(BuildContext context,
      {required String msg, Duration? duration, Color? color = defaultColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.only(bottom: 520.h, left: 10.w, right: 10.w),
        duration: duration ?? const Duration(milliseconds: 4000),
        content: Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyles.textStyle18.copyWith(color: Colors.white),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
