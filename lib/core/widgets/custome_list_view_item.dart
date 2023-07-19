import 'package:flutter/material.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../main.dart';
import '../models/doctor_model.dart';
import '../styles/app_colors.dart';
import 'custome_text_info.dart';

class CustomeListViewItem extends StatelessWidget {
  final void Function()? onPressed;
  final DoctorModel doctorModel;
  final void Function() iconOnPressed;
  const CustomeListViewItem({
    super.key,
    this.onPressed,
    required this.doctorModel,
    required this.iconOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .15,
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.height * .05,
              backgroundImage: const AssetImage(AppAssets.defaultImage),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomeTextInfo(
                  text:
                      'Dr. ${doctorModel.user.firstName} ${doctorModel.user.lastName}',
                  iconData: Icons.location_history,
                ),
                const SizedBox(height: 5),
                CustomeTextInfo(
                  iconData: Icons.email,
                  text: doctorModel.user.email,
                ),
                const SizedBox(height: 5),
                CustomeTextInfo(
                  text: doctorModel.user.phoneNum,
                  iconData: Icons.phone,
                ),
              ],
            ),
            IconButton(
              onPressed: iconOnPressed,
              icon: Icon(
                Icons.delete,
                color: defaultColor,
                size: screenSize.width * .1,
              ),
              style: IconButton.styleFrom(),
            ),
          ],
        ),
      ),
    );
  }
}
