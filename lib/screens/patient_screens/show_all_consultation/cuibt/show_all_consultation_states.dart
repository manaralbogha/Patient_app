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
  final List<ConsultationModel> model;

  GetAllPatientConsultationsSuccessState({required this.model});
}

class GetAllPatientConsultationsErrorState extends ShowAllConsultationStates {
  final String failureMsg;

  GetAllPatientConsultationsErrorState({required this.failureMsg});
}
