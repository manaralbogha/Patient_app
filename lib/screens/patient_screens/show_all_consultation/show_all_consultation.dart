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
          return
              // const _Body();
              CustomeErrorWidget(
            errorMsg: state.failureMsg,
          );
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
  const _Body({this.model});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: model!.isEmpty ? 0 : model!.length,
      itemBuilder: (context, index) => Stack(
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 240.w,
                        child: Text(
                          model![index].question,
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Text(
                          model![index].questionDate,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: defaultColor,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 240.w,
                        child: Text(
                          model![index].answer.toString() == "null"
                              ? 'No Answer Yet '
                              : model![index].answer.toString(),
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 80.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            model![index].answer.toString() == "null"
                                ? const Icon(
                                    Icons.priority_high_rounded,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.check_circle_outlined,
                                    color: Colors.green,
                                  ),
                            if (model![index].answer.toString() != "null")
                              Divider(
                                color: defaultColor,
                                height: 10.h,
                              ),
                            if (model![index].answer.toString() != "null")
                              Text(model![index].answerDate.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 5.w,
            top: 0,
            child: Icon(
              // model![index].answer.toString() == "null"
              // ?
              Icons.question_mark,
              // : Icons.check_rounded,
              size: 60,
              color: model![index].answer.toString() == "null"
                  ? Colors.orange
                  : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
