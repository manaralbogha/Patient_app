import 'package:equatable/equatable.dart';
import 'package:patient_app/core/models/doctor_model.dart';

abstract class DoctorDetailsStates extends Equatable {
  @override
  List<Object> get props => [];
}

class DoctorDetailsInitial extends DoctorDetailsStates {}

class DoctorDetailsLoading extends DoctorDetailsStates {}

class DoctorDetaisFailure extends DoctorDetailsStates {
  final String failureMsg;

  DoctorDetaisFailure({required this.failureMsg});
}

class FetchDoctorDetailsSuccess extends DoctorDetailsStates {
  final DoctorModel doctorModel;

  FetchDoctorDetailsSuccess({required this.doctorModel});
}

class FavouriteSuccessState extends DoctorDetailsStates {}

class CheckFavouriteState extends DoctorDetailsStates {}

class AddEvaluteSuccess extends DoctorDetailsStates {}

class UpdateImageState extends DoctorDetailsStates {}
