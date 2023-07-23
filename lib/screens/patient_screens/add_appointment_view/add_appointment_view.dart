import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'package:patient_app/core/functions/custome_snack_bar.dart';
import 'package:patient_app/core/models/doctor_model.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import 'package:patient_app/core/styles/text_styles.dart';
import 'package:patient_app/core/widgets/custome_button.dart';
import 'package:patient_app/core/widgets/custome_error_widget.dart';
import 'package:patient_app/core/widgets/custome_image.dart';
import 'package:patient_app/core/widgets/custome_progress_indicator.dart';
import '../../../core/widgets/custome_arrow_back_button.dart';
import 'cubit/add_appointment_cubit.dart';
import 'cubit/add_appointment_states.dart';

class AddAppointmentView extends StatelessWidget {
  static const route = 'AddAppointmentView';
  const AddAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    DoctorModel doctorModel =
        ModalRoute.of(context)!.settings.arguments as DoctorModel;
    return BlocProvider(
      create: (context) => AddAppointmentCubit(),
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: defaultColor,
            body: AddAppointmentViewBody(doctorModel: doctorModel),
          ),
        ),
      ),
    );
  }
}

class AddAppointmentViewBody extends StatelessWidget {
  final DoctorModel doctorModel;
  const AddAppointmentViewBody({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAppointmentCubit, AddAppointmentStates>(
      builder: (context, state) {
        if (state is AddAppointmentFailureState) {
          return CustomeErrorWidget(
            errorMsg: state.failureMsg,
          );
        } else if (state is AddAppointmentSuccessState) {
          return _Body(
            key: key,
            doctorModel: doctorModel,
          );
        } else if (state is AddAppointmentLodgingState) {
          return const CustomeProgressIndicator();
        } else {
          return _Body(
            key: key,
            doctorModel: doctorModel,
          );
        }
      },
    );
  }
}

class _Body extends StatelessWidget {
  final DoctorModel doctorModel;
  const _Body({
    super.key,
    required this.doctorModel,
  });

  @override
  Widget build(BuildContext context) {
    AddAppointmentCubit cubit = BlocProvider.of<AddAppointmentCubit>(context);
    cubit.createDatesList();
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
                  addAppointmentCubit: cubit,
                  key: key,
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.r),
                topRight: Radius.circular(25.r),
              ),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _TimesButtons(addAppointmentCubit: cubit),
                    SizedBox(
                      height: 10.h,
                    ),
                    Form(
                      key: cubit.formKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'required';
                          }
                          return null;
                        },
                        maxLines: 3,
                        controller: cubit.discretionController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          hintText: "Description . . .",
                          hintStyle: TextStyle(
                              fontSize: 20,
                              color: defaultColor.withOpacity(.6)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomeButton(
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          if (cubit.addAppointmentModel.date == null) {
                            CustomeSnackBar.showSnackBar(
                              context,
                              msg: 'Please Select a Day',
                              color: Colors.red,
                            );
                          } else if (cubit.addAppointmentModel.time == null) {
                            CustomeSnackBar.showSnackBar(
                              context,
                              msg: 'Please Select a Time',
                              color: Colors.red,
                            );
                          } else {
                            cubit.addAppointment(
                              token: CacheHelper.getData(key: 'Token'),
                              departmentID: doctorModel.departmentID,
                              doctorID: doctorModel.id,
                            );
                          }
                        }
                      },
                      text: 'ADD',
                      width: double.infinity,
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _TimesButtons extends StatelessWidget {
  const _TimesButtons({
    required this.addAppointmentCubit,
  });

  final AddAppointmentCubit addAppointmentCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        2,
        (indexR) => Column(
          children: List.generate(
            addAppointmentCubit.times1.length,
            (index) => _timeDialogButton(
              context,
              onTap: () {
                addAppointmentCubit.selectTime(index: index, indexR: indexR);
              },
              time: indexR == 0
                  ? addAppointmentCubit.times1[index]
                  : addAppointmentCubit.times2[index],
              selectIndexTime: addAppointmentCubit.selectIndexTime != null
                  ? addAppointmentCubit.selectIndexTime!.toInt()
                  : null,
              timeSelected: addAppointmentCubit.addAppointmentModel.time,
              index: index,
            ),
          ),
        ),
      ),
    );
  }
}

Widget _timeDialogButton(
  BuildContext context, {
  required void Function() onTap,
  required String time,
  int? selectIndexTime,
  required int index,
  String? timeSelected,
  // required String value,
}) {
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
        const CustomArrowBackIconButton(),
      ],
    );
  }
}
