import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_colors.dart';

class CustomDrawerButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? iconColor;
  final void Function() onPressed;
  const CustomDrawerButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        fixedSize: Size(220.w, 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          SizedBox(
            width: 10.w,
          ),
          Icon(
            icon,
            size: 25.w,
            color: iconColor ?? defaultColor,
          ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.w, color: Colors.black54),
            ),
          ),
        ],
      ),
      // icon: Icon(
      //   icon,
      //   size: 25.w,
      //   color: iconColor ?? defaultColor,
      // ),
      // label: Text(
      //   text,
      //   style: TextStyle(fontSize: 20.w, color: Colors.black54),
      // ),
    );
  }
}
