import 'package:equatable/equatable.dart';
import 'package:patient_app/core/models/department_model.dart';
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

class GetDoctorsSuccess extends HomePatientStates {
  final List<DoctorModel> doctors;

  GetDoctorsSuccess({required this.doctors});
}

class GetDepartmentsSuccess extends HomePatientStates {
  final List<DepartmentModel> departments;

  GetDepartmentsSuccess({required this.departments});
}

class LogOutState extends HomePatientStates {}
