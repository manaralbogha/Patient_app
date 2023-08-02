import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/text_styles.dart';

class TimeButton extends StatelessWidget {
  final void Function() onTap;
  final String time;
  final int? selectIndexTime;
  final int index;
  final String? timeSelected;
  const TimeButton({
    super.key,
    required this.onTap,
    required this.time,
    required this.index,
    this.selectIndexTime,
    this.timeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: InkWell(
        // splashColor: Colors.amber,
        borderRadius: BorderRadius.circular(25.r),
        onTap: onTap,
        child: Container(
          width: 150.w,
          // margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            border: Border.all(
                color: selectIndexTime == index && timeSelected == time
                    ? Colors.green
                    : Colors.black),
            borderRadius: BorderRadius.circular(25.r),
            color: selectIndexTime == index && timeSelected == time
                ? Colors.grey.shade200
                : Colors.white24,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                time,
                style: TextStyles.textStyle20.copyWith(
                    color: selectIndexTime == index && timeSelected == time
                        ? Colors.green
                        : defaultColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
