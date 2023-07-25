import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'package:patient_app/core/functions/custome_dialogs.dart';
import 'package:patient_app/core/models/doctor_model.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import 'package:patient_app/core/utils/app_assets.dart';
import 'package:patient_app/core/widgets/custome_arrow_back_button.dart';
import 'package:patient_app/core/widgets/custome_button.dart';
import 'package:patient_app/core/widgets/custome_error_widget.dart';
import 'package:patient_app/core/widgets/custome_image.dart';
import 'package:patient_app/core/widgets/custome_progress_indicator.dart';
import 'package:patient_app/main.dart';
import 'package:patient_app/screens/patient_screens/doctor_details_screen/cubit/doctor_details_cubit.dart';
import 'package:patient_app/screens/patient_screens/doctor_details_screen/cubit/doctor_details_states.dart';
import 'package:patient_app/screens/patient_screens/show_all_consultation/show_all_consultation.dart';

import '../add_appointment_view/add_appointment_view.dart';

class DoctorDetailsView extends StatelessWidget {
  static const route = 'DoctorDetailsView';

  const DoctorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorModel doctorModel =
        ModalRoute.of(context)?.settings.arguments as DoctorModel;
    return BlocProvider(
      create: (context) => DoctorDetailsCubit(),
      child: Scaffold(
        body: DoctorDetailsViewBody(doctorModel: doctorModel),
        floatingActionButton:
            BlocBuilder<DoctorDetailsCubit, DoctorDetailsStates>(
          builder: (context, state) => FloatingActionButton(
            tooltip: 'Add a consultation',
            onPressed: () {
              // BlocProvider.of<DoctorDetailsCubit>(context).visible =
              //     BlocProvider.of<DoctorDetailsCubit>(context).visible;
              _showBottomSheet(
                context,
                doctorModel: doctorModel,
                cubit: BlocProvider.of<DoctorDetailsCubit>(context),
              );
            },
            child: const Icon(
              Icons.chat,
              color: defaultColor,
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context,
      {required DoctorModel doctorModel, required DoctorDetailsCubit cubit}) {
    final formKey = GlobalKey<FormState>();
    String? question;
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            cubit.udpateImageState(visibility: true);
          },
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Container(
                  height: 4,
                  margin: EdgeInsets.symmetric(
                      vertical: screenSize.height * .015,
                      horizontal: screenSize.width * .4),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(height: 10.h),
                const Text(
                  'Note: You will Lose 1000 from your account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 10.h),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ShowAllConsultationView.route,
                      arguments: doctorModel.id,
                    );
                  },
                  highlightColor: defaultColor.withOpacity(.4),
                  borderRadius: BorderRadius.circular(10),
                  child: Text(
                    '  View All>>',
                    style: TextStyle(color: defaultColor.withOpacity(.9)),
                  ),
                ),
                SizedBox(height: 10.h),
                Form(
                  key: formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'required';
                      }
                      return null;
                    },
                    onChanged: (value) => question = value,
                    onTap: () => cubit.udpateImageState(visibility: false),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.black.withOpacity(.3),
                        ),
                        hintText: 'Enter Your Question ...'),
                    maxLines: 5,
                    autofocus: false,
                  ),
                ),
                SizedBox(height: 10.h),
                CustomeButton(
                  text: 'Send Consultation',
                  onPressed: () async {
                    log('${doctorModel.id}');
                    if (formKey.currentState!.validate()) {
                      cubit.addConsultation(
                        context,
                        doctorID: doctorModel.id,
                        question: question!,
                      );
                    }
                  },
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        );
      },
    ).whenComplete(
      () => BlocProvider.of<DoctorDetailsCubit>(context)
          .udpateImageState(visibility: true),
    );
  }
}

class DoctorDetailsViewBody extends StatelessWidget {
  final DoctorModel doctorModel;
  const DoctorDetailsViewBody({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorDetailsCubit, DoctorDetailsStates>(
      builder: (context, state) {
        if (state is DoctorDetailsLoading) {
          return const CustomeProgressIndicator();
        } else if (state is DoctorDetaisFailure) {
          return CustomeErrorWidget(errorMsg: state.failureMsg);
        } else {
          return _Body(doctorModel: doctorModel);
        }
      },
    );
  }
}

class _Body extends StatelessWidget {
  final DoctorModel doctorModel;
  const _Body({required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    DoctorDetailsCubit cubit = BlocProvider.of<DoctorDetailsCubit>(context);
    return BlocBuilder<DoctorDetailsCubit, DoctorDetailsStates>(
      builder: (context, state) {
        return Stack(
          children: [
            CustomeImage(
              image: AppAssets.stethoscope,
              width: screenSize.width,
              height: screenSize.height * .33,
            ),
            Positioned(
              left: screenSize.width * .85,
              top: 22.h,
              child: const CustomArrowBackIconButton(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.r),
                    topRight: Radius.circular(25.r),
                  ),
                ),
                height: screenSize.height * .75,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 60.h,
                          width: screenSize.width,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Dr. ${doctorModel.user.firstName} ${doctorModel.user.lastName}',
                            style: TextStyle(
                              fontSize: 20.h,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(.7),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Cardiac Surgery Doctor',
                            style: TextStyle(
                              fontSize: 13.h,
                              fontWeight: FontWeight.w500,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '(${doctorModel.review}.0 / 5) ⭐️',
                            style: TextStyle(
                              fontSize: 15.h,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 25.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DoctorDetailsButton(
                              text: cubit.favouriteText,
                              icon: cubit.favouriteIcon,
                              onPressed: () {
                                if (cubit.favouriteText == 'Add To Favourite') {
                                  cubit.addToFavourite(
                                    doctorID: doctorModel.id,
                                    token: CacheHelper.getData(key: 'Token'),
                                  );
                                } else {
                                  cubit.deleteFromFavourite(
                                    favouriteID: 6,
                                    token: CacheHelper.getData(key: 'Token'),
                                  );
                                }
                              },
                            ),
                            Container(
                              color: Colors.grey,
                              width: 1,
                              height: 40.h,
                            ),
                            DoctorDetailsButton(
                              text: 'Rating Doctor',
                              icon: Icon(
                                Icons.star_border,
                                color: Colors.grey,
                                size: 30.w,
                              ),
                              onPressed: () {
                                CustomDialogs.showRatingDialog(
                                  context,
                                  onPressed: () {
                                    cubit.ratingValue =
                                        CustomDialogs.helperGetRatingIndex();
                                    Navigator.pop(context);
                                    cubit.addEvaluation(
                                      doctorID: doctorModel.id,
                                      token: CacheHelper.getData(key: 'Token'),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 25.h),
                        CustomeButton(
                          text: 'Appointment Booking',
                          borderRadius: BorderRadius.circular(10),
                          width: screenSize.width,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AddAppointmentView.route,
                              arguments: doctorModel,
                            );
                          },
                        ),
                        SizedBox(height: 25.h),
                        Text(
                          'About Doctor',
                          style: TextStyle(
                            fontSize: 15.h,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(.677),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          doctorModel.description,
                          // 'Doctorate in Psychiatry Postgraduate degree in Psychiatry\nBeirut University in 1996\nBoard Certified in Psychiatry',
                          style: TextStyle(
                            fontSize: 12.h,
                            color: Colors.black.withOpacity(.677),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: cubit.visible,
              child: Row(
                children: [
                  const Expanded(child: SizedBox()),
                  CustomeImage(
                    borderRadius: BorderRadius.circular(50.h),
                    margin: EdgeInsets.only(top: screenSize.height * .16),
                    height: 100.h,
                    width: 95.h,
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class DoctorDetailsButton extends StatelessWidget {
  final String text;
  final Icon icon;
  final void Function() onPressed;
  const DoctorDetailsButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Column(
            children: [
              Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.w,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              icon,
            ],
          ),
        ),
      ),
    );
  }
}
