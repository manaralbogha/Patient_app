import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import 'package:patient_app/core/styles/text_styles.dart';
import 'package:patient_app/core/widgets/custome_image.dart';
import 'package:patient_app/screens/add_appointment_view/cubit/add_appointment_cubit.dart';
import 'package:patient_app/screens/add_appointment_view/cubit/add_appointment_states.dart';
import 'package:patient_app/screens/login_screen/login_screen.dart';

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
    AddAppointmentCubit addAppointmentCubit =
        BlocProvider.of<AddAppointmentCubit>(context);
    addAppointmentCubit.createDatesList();
    return Column(
      children: [
        SizedBox(
          height: 200.h,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CustomAppBar(key: key),
                const Spacer(),
                _DatesListView(
                  addAppointmentCubit: addAppointmentCubit,
                  key: key,
                )
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

class _DatesListView extends StatelessWidget {
  const _DatesListView({
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
                addAppointmentCubit.selectDay(index: index);
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

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 90.w,
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
                right: 20.w,
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
            onTap: () {
              CacheHelper.deletData(key: 'Token');
              Navigator.popAndPushNamed(context, LoginView.route);
            },
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
