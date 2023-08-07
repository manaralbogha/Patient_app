import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/models/appointment_model.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/cubits/my_appointments_cubit/my_appointments_cubit.dart';
import '../../../../core/widgets/custome_image.dart';

class MyAppointmentItem extends StatelessWidget {
  final AppointmentModel appointmentModel;

  const MyAppointmentItem({
    super.key,
    required this.appointmentModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              appointmentModel.doctorModel.imagePath != 'default'
                  ? CustomeNetworkImage(
                      imageUrl: appointmentModel.doctorModel.imagePath,
                      borderRadius: BorderRadius.circular(10),
                      fit: BoxFit.fill,
                      width: 70.h,
                      height: 90.h,
                    )
                  : CustomeImage(
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
                  Row(
                    children: [
                      _TextItem(
                        text: 'Time: ',
                        color: Colors.black.withOpacity(.6),
                        fontWeight: FontWeight.bold,
                        fontSize: 15.w,
                        width: 50.w,
                      ),
                      _TextItem(
                        text:
                            '${appointmentModel.date} - At ${appointmentModel.time}',
                        width: 170.w,
                        fontSize: 12.6.w,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.w),
                  Row(
                    children: [
                      appointmentModel.departmentModel.img != 'default'
                          ? CustomeNetworkImage(
                              imageUrl: appointmentModel.departmentModel.img,
                              width: 25.h,
                              height: 25.h,
                              fit: BoxFit.cover,
                              // iconSize: 15.h,
                              borderRadius: BorderRadius.circular(30),
                            )
                          : CustomeImage(
                              width: 25.h,
                              height: 25.h,
                              iconSize: 18.h,
                              borderRadius: BorderRadius.circular(30),
                            ),
                      SizedBox(width: 5.w),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _TextItem(
                            text: 'Doctor: ',
                            color: Colors.black.withOpacity(.6),
                            fontSize: 15.w,
                            fontWeight: FontWeight.bold,
                            width: 60.w,
                          ),
                          _TextItem(
                            // text: 'To: Dr. ${appointmentModel.d}',
                            text:
                                '${appointmentModel.doctorModel.user.firstName} ${appointmentModel.doctorModel.user.lastName}',
                            width: 150.w,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.w),
                  Row(
                    children: [
                      _TextItem(
                        text: 'Status: ',
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(.6),
                        fontSize: 15.w,
                        width: 60.w,
                      ),
                      _TextItem(
                        text: '${appointmentModel.status}...',
                        color: Colors.green,
                        width: 90.w,
                      ),
                      Visibility(
                        visible: appointmentModel.status == 'waiting',
                        child: _CancelButton(
                          patientID: appointmentModel.patientId,
                          appointmentID: appointmentModel.id,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  final int appointmentID;
  final int patientID;
  const _CancelButton({required this.appointmentID, required this.patientID});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAppointmentsCubit, MyAppointmentsStates>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            BlocProvider.of<MyAppointmentsCubit>(context).cancelAppointment(
              appointmentID: appointmentID,
              patientID: patientID,
            );
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
  final FontWeight? fontWeight;
  final double? fontSize;
  const _TextItem({
    required this.text,
    this.width,
    this.color,
    this.fontWeight,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 235.w,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize ?? 13.w,
          color: color ?? Colors.black.withOpacity(.46),
        ),
      ),
    );
  }
}
