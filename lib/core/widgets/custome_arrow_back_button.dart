import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../screens/login_screen/login_screen.dart';
import '../api/services/local/cache_helper.dart';

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
          CacheHelper.deletData(key: 'Token');
          CacheHelper.deletData(key: 'Role');
          Navigator.popAndPushNamed(context, LoginView.route);
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
