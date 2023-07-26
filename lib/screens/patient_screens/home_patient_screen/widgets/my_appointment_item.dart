import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/cubits/my_appointments_cubit/my_appointments_cubit.dart';
import '../../../../core/widgets/custome_image.dart';

class MyAppointmentItem extends StatelessWidget {
  final String time;
  final String doctor;
  final String status;
  final int appointmentID;
  const MyAppointmentItem({
    super.key,
    required this.time,
    required this.doctor,
    required this.status,
    required this.appointmentID,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {},
      child: Container(
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
              height: 90.h,
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // const _TextItem(text: 'From: Abdullah Nahlawi xxxxxxxxx'),
                // SizedBox(height: 8.w),
                _TextItem(text: 'Time: $time'),
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
                      text: 'To: Dr. $doctor',
                      width: 208.w,
                    ),
                  ],
                ),
                SizedBox(height: 8.w),
                Row(
                  children: [
                    _TextItem(
                      text: 'Status:',
                      width: 65.w,
                    ),
                    _TextItem(
                      text: status,
                      color: Colors.green,
                      width: 100.w,
                    ),
                    Visibility(
                      visible: status == 'waiting...',
                      child: _CancelButton(
                        appointmentID: appointmentID,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  final int appointmentID;
  const _CancelButton({required this.appointmentID});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAppointmentsCubit, MyAppointmentsStates>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            BlocProvider.of<MyAppointmentsCubit>(context)
                .cancelAppointment(appointmentID: appointmentID);
          },
          highlightColor: Colors.black.withOpacity(.7),
          borderRadius: BorderRadius.circular(30.h),
          child: Container(
            width: 70.h,
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.h),
              color: Colors.red.withOpacity(.6),
            ),
            child: const Text(
              'Cancel',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TextItem extends StatelessWidget {
  final String text;
  final double? width;
  final Color? color;
  const _TextItem({required this.text, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 235.w,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontSize: 17,
          color: color ?? Colors.black.withOpacity(.46),
        ),
      ),
    );
  }
}
