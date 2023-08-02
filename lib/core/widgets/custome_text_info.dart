import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/widgets/custome_icon.dart';

import '../styles/text_styles.dart';

class CustomeTextInfo extends StatelessWidget {
  final String text;
  final IconData iconData;
  const CustomeTextInfo(
      {super.key, required this.text, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon(
        //   iconData,
        //   color: defaultColor,
        // ),
        CustomeIcon(icon: iconData),
        SizedBox(width: 10.w),
        SizedBox(
          width: 175.w,
          child: Text(
            text,
            style: TextStyles.textStyle16.copyWith(color: Colors.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
