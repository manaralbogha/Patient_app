import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/app_colors.dart';
import '../styles/text_styles.dart';

abstract class CustomeSnackBar {
  static void showSnackBar(
    BuildContext context, {
    required String msg,
    Duration? duration,
    Color? color = defaultColor,
    double? fontSize,
    bool hasAction = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.only(bottom: 520.h, left: 10.w, right: 10.w),
        duration: duration ?? const Duration(milliseconds: 4000),
        action: hasAction
            ? SnackBarAction(
                label: 'X',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              )
            : null,
        content: Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyles.textStyle18.copyWith(
            color: Colors.white,
            fontSize: fontSize ?? 18.sp,
          ),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }

  static void showErrorSnackBar(
    BuildContext context, {
    required String msg,
    Duration? duration,
    Color? color = Colors.red,
    double? fontSize,
    bool hasAction = true,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.only(bottom: 200.h, left: 10.w, right: 10.w),
        duration: duration ?? const Duration(minutes: 2),
        // action: hasAction
        //     ? SnackBarAction(
        //         backgroundColor: Colors.white,
        //         textColor: Colors.black,
        //         label: 'Hide',
        //         onPressed: () {
        //           ScaffoldMessenger.of(context).hideCurrentSnackBar();
        //         },
        //       )
        //     : null,
        content: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 220.h,
              child: SingleChildScrollView(
                child: Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: TextStyles.textStyle18.copyWith(
                    color: Colors.white,
                    fontSize: fontSize ?? 18.sp,
                  ),
                ),
              ),
            ),
          ],
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
