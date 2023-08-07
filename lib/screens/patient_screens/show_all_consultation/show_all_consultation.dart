import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'package:patient_app/core/models/consultation_model.dart';
import 'package:patient_app/core/widgets/custome_error_widget.dart';
import 'package:patient_app/screens/patient_screens/show_all_consultation/cuibt/show_all_consultation_cubit.dart';
import 'package:patient_app/screens/patient_screens/show_all_consultation/cuibt/show_all_consultation_states.dart';
import 'package:patient_app/screens/patient_screens/show_all_consultation/widgets/consultation_item.dart';
import '../../../core/widgets/custome_progress_indicator.dart';

class ShowAllConsultationView extends StatelessWidget {
  static const route = 'ShowAllConsultationView';

  const ShowAllConsultationView({super.key});

  @override
  Widget build(BuildContext context) {
    int? doctorID = ModalRoute.of(context)!.settings.arguments as int?;
    return BlocProvider(
      create: (context) => ShowAllConsultationCubit()
        ..getAllPatientConsultations(
          token: CacheHelper.getData(key: 'Token'),
        ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Your Questions')),
        body: ShowAllConsultationViewBody(doctorID: doctorID),
      ),
    );
  }
}

class ShowAllConsultationViewBody extends StatelessWidget {
  final int? doctorID;
  const ShowAllConsultationViewBody({
    super.key,
    this.doctorID,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowAllConsultationCubit, ShowAllConsultationStates>(
      builder: (context, state) {
        if (state is GetAllPatientConsultationsErrorState) {
          return CustomeErrorWidget(errorMsg: state.failureMsg);
        } else if (state is GetAllPatientConsultationsLoadingState) {
          return const CustomeProgressIndicator();
        } else if (state is GetAllPatientConsultationsSuccessState) {
          if (doctorID == null) {
            return _Body(model: state.allConsulations);
          } else {
            return _Body(
                model: state.getDoctorConsulations(doctorID: doctorID!));
          }
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
    return (model != null && model!.isNotEmpty)
        ? ListView.builder(
            itemCount: model!.length,
            itemBuilder: (context, index) =>
                ConsultationItem(consultationModel: model![index]),
          )
        : Center(
            child: Text(
              'No Questions Sent',
              style: TextStyle(color: Colors.grey, fontSize: 20.w),
            ),
          );
  }
}
