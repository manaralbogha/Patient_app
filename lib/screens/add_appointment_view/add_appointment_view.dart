import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import 'package:patient_app/core/styles/text_styles.dart';
import 'package:patient_app/core/utils/app_assets.dart';
import 'package:patient_app/core/widgets/custome_image.dart';
import 'package:patient_app/screens/add_appointment_view/cubit/add_appointment_cubit.dart';
import 'package:patient_app/screens/add_appointment_view/cubit/add_appointment_states.dart';

class AddAppointmentView extends StatelessWidget {
  static const route = 'AddAppointmentView';
  const AddAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddAppointmentCubit(),
      child: const SafeArea(
          child: Scaffold(
        backgroundColor: defaultColor,
        body: AddAppointmentViewBody(),
      )),
    );
  }
}

class AddAppointmentViewBody extends StatelessWidget {
  const AddAppointmentViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAppointmentCubit, AddAppointmentStates>(
      builder: (context, state) {
        return _Body(
          key: key,
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200.h,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
            child: Column(
              children: [
                _CustomAppBar(key: key),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.r),
                topRight: Radius.circular(25.r),
              ),
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100.w,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CustomeImage(
                // image: AppAssets.defaultImage,
                height: 40.h,
                width: 45.w,
                borderRadius: BorderRadius.circular(50.r),
              ),
              Positioned(
                right: 32.w,
                child: CustomeImage(
                  // image: AppAssets.loginImage,
                  height: 40.h,
                  width: 45.w,
                  borderRadius: BorderRadius.circular(50.r),
                ),
              ),
            ],
          ),
        ),
        Text(
          'Add Appointment',
          style: TextStyles.textStyle20.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const Spacer(),
        Container(
          height: 30.h,
          width: 33.w,
          decoration: BoxDecoration(
              color: Colors.white12, borderRadius: BorderRadius.circular(50.r)),
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.r),
            ),
            onTap: () {},
            child: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
        )
      ],
    );
  }
}
