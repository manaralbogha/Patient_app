import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/custome_image.dart';

class AppointmentRequestItem extends StatelessWidget {
  const AppointmentRequestItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomeImage(
            borderRadius: BorderRadius.circular(10),
            width: 70.h,
            height: 85.h,
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const _TextItem(text: 'From: Abdullah Nahlawi xxxxxxxxx'),
              SizedBox(height: 8.w),
              const _TextItem(text: 'Sunday 5/7  03:00 PM'),
              SizedBox(height: 8.w),
              Row(
                children: [
                  CustomeImage(
                    width: 20.h,
                    height: 20.h,
                    iconSize: 15.h,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  SizedBox(width: 5.w),
                  _TextItem(
                    text: 'Dr. Abdullah Nahlawi',
                    width: 150.w,
                  ),
                ],
              ),
            ],
          ),
          const _HandleButton(),
        ],
      ),
    );
  }
}

class _HandleButton extends StatelessWidget {
  const _HandleButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      highlightColor: Colors.black.withOpacity(.7),
      borderRadius: BorderRadius.circular(30.h),
      child: Container(
        width: 70.h,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.h),
          color: Colors.green.withOpacity(.6),
        ),
        child: const Text(
          'Handle',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class _TextItem extends StatelessWidget {
  final String text;
  final double? width;
  // ignore: unused_element
  const _TextItem({required this.text, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 175.w,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontSize: 17,
          color: Colors.black.withOpacity(.46),
        ),
      ),
    );
  }
}
