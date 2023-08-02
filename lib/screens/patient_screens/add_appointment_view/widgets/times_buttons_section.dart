import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/screens/patient_screens/add_appointment_view/widgets/time_button.dart';
import '../cubit/add_appointment_cubit.dart';

class TimesButtons extends StatelessWidget {
  const TimesButtons({
    super.key,
    required this.addAppointmentCubit,
  });

  final AddAppointmentCubit addAppointmentCubit;

  @override
  Widget build(BuildContext context) {
    if (addAppointmentCubit.selectIndexDay != null) {
      return addAppointmentCubit.times1.isNotEmpty &&
              addAppointmentCubit.times2.isNotEmpty
          ? SizedBox(
              height: addAppointmentCubit.times1.length < 6 ? 265.h : null,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  2,
                  (indexR) => Column(
                    children: List.generate(
                      indexR == 0
                          ? addAppointmentCubit.times1.length
                          : addAppointmentCubit.times2.length,
                      (index) => TimeButton(
                        onTap: () {
                          addAppointmentCubit.selectTime(
                              index: index, indexR: indexR);
                        },
                        time: indexR == 0
                            ? addAppointmentCubit.times1[index]
                            : addAppointmentCubit.times2[index],
                        selectIndexTime:
                            addAppointmentCubit.selectIndexTime != null
                                ? addAppointmentCubit.selectIndexTime!.toInt()
                                : null,
                        timeSelected:
                            addAppointmentCubit.addAppointmentModel.time,
                        index: index,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : SizedBox(
              height: 265.h,
              child: const Center(
                child: Text(
                  'No Availabll Times',
                  style: TextStyle(fontSize: 30, color: Colors.black54),
                ),
              ),
            );
    } else {
      return SizedBox(
        height: 265.h,
        child: const Center(
          child: Text(
            'Please Select Day',
            style: TextStyle(fontSize: 30, color: Colors.black54),
          ),
        ),
      );
    }
  }
}
