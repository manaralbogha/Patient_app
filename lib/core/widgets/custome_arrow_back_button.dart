import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomArrowBackIconButton extends StatelessWidget {
  const CustomArrowBackIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 33.w,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.6),
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
        ),
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_forward_ios_outlined,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
