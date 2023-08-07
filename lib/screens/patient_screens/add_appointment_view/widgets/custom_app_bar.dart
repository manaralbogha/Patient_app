import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/models/doctor_model.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/widgets/custome_arrow_back_button.dart';
import '../../../../core/widgets/custome_image.dart';

class CustomAppBar extends StatelessWidget {
  final DoctorModel doctorModel;
  const CustomAppBar({
    super.key,
    required this.doctorModel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const CustomArrowBackIconButton(),
        const Spacer(flex: 2),
        Text(
          'Add Appointment',
          style: TextStyles.textStyle20.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const Spacer(flex: 1),
        SizedBox(
          width: 60.w,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              doctorModel.departmentImage == null
                  ? CustomeImage(
                      height: 40.h,
                      width: 45.w,
                      borderRadius: BorderRadius.circular(50.r),
                    )
                  : CustomeNetworkImage(
                      imageUrl: doctorModel.departmentImage,
                      height: 40.h,
                      width: 45.w,
                      borderRadius: BorderRadius.circular(50.r),
                      fit: BoxFit.cover,
                    ),
              Positioned(
                left: 30.w,
                child: doctorModel.imagePath == 'default'
                    ? CustomeImage(
                        height: 40.h,
                        width: 45.w,
                        borderRadius: BorderRadius.circular(50.r),
                      )
                    : CustomeNetworkImage(
                        imageUrl: doctorModel.imagePath,
                        height: 40.h,
                        width: 45.w,
                        borderRadius: BorderRadius.circular(50.r),
                        fit: BoxFit.cover,
                      ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
