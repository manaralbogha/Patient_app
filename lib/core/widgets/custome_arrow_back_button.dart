import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomArrowBackIconButton extends StatelessWidget {
  final IconData? icon;
  final void Function()? onTap;
  const CustomArrowBackIconButton({super.key, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 33.w,
      padding: EdgeInsets.only(left: 5.w),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.6),
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
        ),
        onTap: onTap ??
            () {
              Navigator.pop(context);
            },
        child: Icon(
          icon ?? Icons.arrow_back_ios,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
