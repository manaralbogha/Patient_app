import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'package:patient_app/core/models/consultation_model.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import 'package:patient_app/core/widgets/custome_error_widget.dart';
import 'package:patient_app/screens/patient_screens/show_all_consultation/cuibt/show_all_consultation_cubit.dart';
import 'package:patient_app/screens/patient_screens/show_all_consultation/cuibt/show_all_consultation_states.dart';

import '../../../core/widgets/custome_progress_indicator.dart';

class ShowAllConsultationView extends StatelessWidget {
  static const route = 'ShowAllConsultationView';
  const ShowAllConsultationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowAllConsultationCubit()
        ..getAllPatientConsultations(
          token: CacheHelper.getData(key: 'Token'),
        ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Your Questions')),
        body: const ShowAllConsultationViewBody(),
      ),
    );
  }
}

class ShowAllConsultationViewBody extends StatelessWidget {
  const ShowAllConsultationViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowAllConsultationCubit, ShowAllConsultationStates>(
      builder: (context, state) {
        if (state is GetAllPatientConsultationsErrorState) {
          return const _Body();
          // CustomeErrorWidget(
          //   errorMsg: state.failureMsg,
          // );
        } else if (state is GetAllPatientConsultationsLoadingState) {
          return const CustomeProgressIndicator();
        } else if (state is GetAllPatientConsultationsSuccessState) {
          return _Body(
            model: state.model,
          );
        } else {
          return const _Body();
        }
      },
    );
  }
}

class _Body extends StatelessWidget {
  final List<ConsultationModel>? model;
  const _Body({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => Container(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 25.h, horizontal: 10.w),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: defaultColor),
                borderRadius: BorderRadius.circular(10.r),
              ),
              // height: 150.h,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 275.w,
                      child: Text(
                        'can i use newaid for headach??can i use newaid for headach??',
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                    const Divider(
                      color: defaultColor,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 275.w,
                          child: Text(
                            'yes youcan',
                            style: TextStyle(fontSize: 20.sp),
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.priority_high_rounded,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                right: 5.w,
                top: 0,
                child: const Icon(
                  Icons.question_mark,
                  size: 60,
                  color: Colors.orange,
                )),
          ],
        ),
      ),
    );
  }
}
