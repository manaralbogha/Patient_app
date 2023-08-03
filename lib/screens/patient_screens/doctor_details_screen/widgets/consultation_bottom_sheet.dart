import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/doctor_model.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custome_button.dart';
import '../../../../main.dart';
import '../../show_all_consultation/show_all_consultation.dart';
import '../cubit/doctor_details_cubit.dart';

abstract class ConsultationBottomSheet {
  static void showConsultationBottomSheet(
    BuildContext context, {
    required DoctorModel doctorModel,
    required DoctorDetailsCubit cubit,
  }) {
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
                Text(
                  'Note: You will Lose ${doctorModel.consultationPrice} from your wallet',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
      () => cubit.udpateImageState(visibility: true),
    );
  }
}
