import 'package:equatable/equatable.dart';

import '../../../../core/models/consultation_model.dart';

abstract class ShowAllConsultationStates extends Equatable {
  @override
  List<Object> get props => [];
}

class ShowAllConsultationInitial extends ShowAllConsultationStates {}

class GetAllPatientConsultationsLoadingState
    extends ShowAllConsultationStates {}

class GetAllPatientConsultationsSuccessState extends ShowAllConsultationStates {
  final List<ConsultationModel> allConsulations;

  GetAllPatientConsultationsSuccessState({required this.allConsulations});

  List<ConsultationModel> getDoctorConsulations({required int doctorID}) {
    List<ConsultationModel> list = [];
    for (ConsultationModel item in allConsulations) {
      if (item.doctorID == doctorID) {
        list.add(item);
      }
    }
    return list;
  }
}

class GetAllPatientConsultationsErrorState extends ShowAllConsultationStates {
  final String failureMsg;

  GetAllPatientConsultationsErrorState({required this.failureMsg});
}
