import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/api/services/favourite/add_to_favourite_service.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import 'package:patient_app/core/utils/app_assets.dart';
import 'package:patient_app/core/widgets/custome_arrow_back_button.dart';
import 'package:patient_app/core/widgets/custome_button.dart';
import 'package:patient_app/core/widgets/custome_image.dart';
import 'package:patient_app/main.dart';
import 'package:patient_app/screens/patient_screens/add_appointment_view/add_appointment_view.dart';

class DoctorDetailsView extends StatelessWidget {
  static const route = 'DoctorDetailsView';
  const DoctorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const DoctorDetailsViewBody(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add a consultation',
        onPressed: () {
          _showBottomSheet(context);
        },
        child: const Icon(
          Icons.chat,
          color: defaultColor,
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
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
          onTap: () => FocusScope.of(context).unfocus(),
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
                  onTap: () {},
                  highlightColor: defaultColor.withOpacity(.4),
                  borderRadius: BorderRadius.circular(10),
                  child: Text(
                    '  View All>>',
                    style: TextStyle(color: defaultColor.withOpacity(.9)),
                  ),
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withOpacity(.3),
                      ),
                      hintText: 'Enter Your Question ...'),
                  maxLines: 5,
                  autofocus: true,
                ),
                SizedBox(height: 10.h),
                CustomeButton(
                  text: 'Send Consultation',
                  onPressed: () {},
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DoctorDetailsViewBody extends StatelessWidget {
  const DoctorDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomeImage(
          image: AppAssets.stethoscope,
          width: screenSize.width,
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
                      'Dr. Abdullah Nahlawi',
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
                  SizedBox(height: 25.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DoctorDetailsButton(
                        text: 'Add To Favourite',
                        icon: Icons.favorite_border,
                        onPressed: () {
                          AddToFavouriteService.addToFavourite(
                            doctorID: 1,
                            token: CacheHelper.getData(key: 'Token'),
                          );
                        },
                      ),
                      Container(
                        color: Colors.grey,
                        width: 1,
                        height: 40.h,
                      ),
                      DoctorDetailsButton(
                        text: 'Rating Doctor',
                        icon: Icons.star_border,
                        onPressed: () {},
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
                      Navigator.pushNamed(context, AddAppointmentView.route);
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
                    'Doctorate in Psychiatry Postgraduate degree in Psychiatry\nBeirut University in 1996\nBoard Certified in Psychiatry',
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
        Row(
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
      ],
    );
  }
}

class DoctorDetailsButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function() onPressed;
  const DoctorDetailsButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              icon,
              color: Colors.grey,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}