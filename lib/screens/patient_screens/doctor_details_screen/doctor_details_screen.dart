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
import 'package:patient_app/screens/patient_screens/doctor_details_screen/widgets/consultation_bottom_sheet.dart';
import 'package:patient_app/screens/patient_screens/doctor_details_screen/widgets/doctor_details_button.dart';
import 'package:patient_app/screens/patient_screens/favourite_screen/favourite_screen.dart';
import '../add_appointment_view/add_appointment_view.dart';

class DoctorDetailsView extends StatelessWidget {
  static const route = 'DoctorDetailsView';
  const DoctorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context)?.settings.arguments;
    final DoctorModel doctorModel = args[0];
    final bool fromFavorite = args[1];
    return BlocProvider(
      create: (context) => DoctorDetailsCubit()
        ..checkIsFavourited(
          token: CacheHelper.getData(key: 'Token'),
          doctorID: doctorModel.id,
        ),
      child: Scaffold(
        body: DoctorDetailsViewBody(
          doctorModel: doctorModel,
          fromFavourite: fromFavorite,
        ),
        floatingActionButton:
            BlocBuilder<DoctorDetailsCubit, DoctorDetailsStates>(
          builder: (context, state) => Visibility(
            visible: state is DoctorDetailsLoading ? false : true,
            child: FloatingActionButton(
              tooltip: 'Add a consultation',
              onPressed: () {
                ConsultationBottomSheet.showConsultationBottomSheet(
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
      ),
    );
  }
}

class DoctorDetailsViewBody extends StatelessWidget {
  final DoctorModel doctorModel;
  final bool fromFavourite;
  const DoctorDetailsViewBody({
    super.key,
    required this.doctorModel,
    required this.fromFavourite,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorDetailsCubit, DoctorDetailsStates>(
      builder: (context, state) {
        if (state is DoctorDetailsLoading) {
          return const CustomeProgressIndicator();
        } else if (state is DoctorDetaisFailure) {
          return CustomeErrorWidget(errorMsg: state.failureMsg);
        } else if (state is FetchDoctorDetailsSuccess) {
          return _Body(
            doctorModel: state.doctorModel,
            fromFavourite: fromFavourite,
          );
        } else {
          return _Body(
            doctorModel: doctorModel,
            fromFavourite: fromFavourite,
          );
        }
      },
    );
  }
}

class _Body extends StatelessWidget {
  final DoctorModel doctorModel;
  final bool fromFavourite;
  const _Body({required this.doctorModel, required this.fromFavourite});

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
              right: screenSize.width * .85,
              top: 25.h,
              child: CustomArrowBackIconButton(
                onTap: fromFavourite
                    ? () {
                        Navigator.popAndPushNamed(context, FavouriteView.route);
                      }
                    : null,
              ),
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
                          height: 80.h,
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
                            // 'Cardiac Surgery Doctor',
                            '${doctorModel.specialty} Doctor',
                            style: TextStyle(
                              fontSize: 16.h,
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
                                    doctorID: doctorModel.id,
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
                                    cubit
                                        .addEvaluation(
                                      doctorID: doctorModel.id,
                                      token: CacheHelper.getData(key: 'Token'),
                                    )
                                        .then((value) {
                                      cubit.getDoctorDetails(
                                          userID: doctorModel.userID);
                                    });
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
                            // log('\nDoctorIMG${doctorModel.imagePath}');
                            // log('\nDoctorIMG${doctorModel.departmentImage}');
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
                  doctorModel.imagePath == 'default'
                      ? CustomeImage(
                          borderRadius: BorderRadius.circular(80.h),
                          margin: EdgeInsets.only(top: screenSize.height * .16),
                          height: 120.h,
                          width: 115.h,
                          iconSize: 50.sp,
                        )
                      : CustomeNetworkImage(
                          imageUrl: doctorModel.imagePath,
                          borderRadius: BorderRadius.circular(80.h),
                          margin: EdgeInsets.only(top: screenSize.height * .16),
                          height: 120.h,
                          width: 115.h,
                          fit: BoxFit.cover,
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
