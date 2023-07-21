import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/styles/app_colors.dart';

class CustomeImage extends StatelessWidget {
  final String? image;
  final double? height, width;
  final double? iconSize;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;
  const CustomeImage({
    super.key,
    this.image,
    this.height,
    this.width,
    this.borderRadius,
    this.iconSize,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height * .25,
      width: width ?? MediaQuery.of(context).size.width * .25,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: borderRadius,
        image: image != null
            ? DecorationImage(fit: BoxFit.fill, image: AssetImage(image!))
            : null,
      ),
      child: image != null
          ? null
          : Icon(
              Icons.person,
              size: iconSize ?? 35.sp,
              color: defaultColor,
            ),
    );
  }
}
