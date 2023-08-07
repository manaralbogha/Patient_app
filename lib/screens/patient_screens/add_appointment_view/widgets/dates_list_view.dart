import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/text_styles.dart';
import '../cubit/add_appointment_cubit.dart';

class DatesListView extends StatelessWidget {
  const DatesListView({
    super.key,
    required this.addAppointmentCubit,
  });

  final AddAppointmentCubit addAppointmentCubit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          addAppointmentCubit.dates.length,
          (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0.w),
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              onTap: () {
                addAppointmentCubit.selectDay(
                    index: index, day: addAppointmentCubit.days[index]);
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                height: 75.h,
                width: 85.w,
                decoration: BoxDecoration(
                  color: addAppointmentCubit.selectIndexDay != index
                      ? Colors.white24
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        addAppointmentCubit.days[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: addAppointmentCubit.selectIndexDay != index
                                ? Colors.white
                                : Colors.black,
                            decoration: addAppointmentCubit.vaildWorkDay(
                                    day: addAppointmentCubit.days[index])
                                ? TextDecoration.none
                                : TextDecoration.lineThrough,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                addAppointmentCubit.days[index] == 'Wednesday'
                                    ? 13.sp
                                    : 14.sp),
                      ),
                      Text(
                        addAppointmentCubit.dates[index],
                        textAlign: TextAlign.center,
                        style: TextStyles.textStyle16.copyWith(
                            fontSize: 12.sp,
                            decoration: addAppointmentCubit.vaildWorkDay(
                                    day: addAppointmentCubit.days[index])
                                ? TextDecoration.none
                                : TextDecoration.lineThrough,
                            color: addAppointmentCubit.selectIndexDay != index
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
