import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/doctor_model.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custome_image.dart';
import '../../doctor_details_screen/doctor_details_screen.dart';

class CustomDoctorItem extends StatelessWidget {
  final DoctorModel doctorModel;
  const CustomDoctorItem({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: 200.w,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, DoctorDetailsView.route,
                  arguments: doctorModel);
            },
            highlightColor: defaultColor.withOpacity(.5),
            borderRadius: BorderRadius.circular(15),
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              surfaceTintColor: Colors.white,
              elevation: 7,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomeImage(
                      image: 'assets/images/register_doctor_image3.jpg',
                      width: 190.w,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    SizedBox(
                      width: 170.w,
                      child: const Divider(
                        thickness: .7,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 5.w),
                    Text(
                      'Dr. ${doctorModel.user.firstName} ${doctorModel.user.lastName}',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17.w,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.w),
                    Text(
                      'Cardiac Surgery Doctor',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.w,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 160.w,
          left: 135.w,
          child: CustomeImage(
            image: 'assets/images/stethoscope_icon.png',
            color: Colors.transparent,
            width: 45.w,
            height: 45.w,
            borderRadius: BorderRadius.circular(40.w),
          ),
        ),
      ],
    );
  }
}
