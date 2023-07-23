import 'package:equatable/equatable.dart';
import '../../../../../core/models/doctor_model.dart';

abstract class HomePatientStates extends Equatable {
  @override
  List<Object> get props => [];
}

class HomePatientInitial extends HomePatientStates {}

class HomePatientLoading extends HomePatientStates {}

class HomePatientFailure extends HomePatientStates {
  final String failureMsg;

  HomePatientFailure({required this.failureMsg});
}

class HomePatientSuccess extends HomePatientStates {
  final List<DoctorModel> doctors;

  HomePatientSuccess({required this.doctors});
}
