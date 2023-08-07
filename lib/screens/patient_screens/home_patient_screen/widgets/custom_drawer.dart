import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custome_image.dart';
import '../../favourite_screen/favourite_screen.dart';
import '../../show_all_consultation/show_all_consultation.dart';
import '../cubits/home_cubit/home_patient_cuibt.dart';
import 'custom_drawer_button.dart';

abstract class CustomDrawer {
  static Drawer getCustomDrawer(
    BuildContext context, {
    required HomePatientCubit homeCubit,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) {
    return Drawer(
      width: 250.w,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200.h,
            color: Colors.transparent,
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CustomeImage(
                    height: 75.h,
                    width: 80.w,
                    borderRadius: BorderRadius.circular(50.r),
                    iconSize: 60.sp,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Center(
                  child: Text(
                    homeCubit.patientModel?.userModel?.firstName ?? '',
                    style:
                        TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Center(
            child: Text(
              'Balance: ${homeCubit.patientModel?.wallet}',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 25.h),
          CustomDrawerButton(
            text: 'Consultations',
            icon: Icons.question_answer,
            onPressed: () {
              scaffoldKey.currentState!.closeDrawer();
              Navigator.pushNamed(
                context,
                ShowAllConsultationView.route,
              );
            },
          ),
          SizedBox(height: 15.h),
          CustomDrawerButton(
            text: 'Favourite',
            icon: Icons.favorite_outlined,
            onPressed: () {
              scaffoldKey.currentState!.closeDrawer();
              Navigator.pushNamed(context, FavouriteView.route);
            },
          ),
          const Expanded(child: SizedBox()),
          CustomDrawerButton(
            text: 'Log Out',
            icon: Icons.logout,
            iconColor: Colors.red,
            onPressed: () {
              scaffoldKey.currentState!.closeDrawer();
              homeCubit.logout(context);
            },
          ),
          SizedBox(height: 25.h),
        ],
      ),
    );
  }
}
