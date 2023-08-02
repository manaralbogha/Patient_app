import 'package:equatable/equatable.dart';
import 'package:patient_app/core/models/department_model.dart';
import '../../../../../core/models/doctor_model.dart';

abstract class HomePatientStates extends Equatable {
  @override
  List<Object> get props => [];
}

// class HomePatientInitial extends HomePatientStates {}

class HomePatientLoading extends HomePatientStates {}

class HomePatientFailure extends HomePatientStates {
  final String failureMsg;

  HomePatientFailure({required this.failureMsg});
}

class GetDoctorsAndDepartmentsSuccess extends HomePatientStates {
  final List<DoctorModel> doctors;
  final List<DepartmentModel> departments;

  GetDoctorsAndDepartmentsSuccess({
    required this.doctors,
    required this.departments,
  });

  List<DoctorModel> getDepartmentDoctors(
      {int? departmentID, String? departmentImg}) {
    List<DoctorModel> doctors = [];
    if (departmentID != null) {
      for (DoctorModel item in this.doctors) {
        if (item.departmentID == departmentID) {
          item.departmentImage = departmentImg;
          doctors.add(item);
        }
      }
      return doctors;
    }
    return doctors;
  }
}

// class GetDepartmentsSuccess extends HomePatientStates {
//   final List<DepartmentModel> departments;

//   GetDepartmentsSuccess({required this.departments});
// }

class LogOutState extends HomePatientStates {}

class ViewDoctorsForDebarmentState extends HomePatientStates {}
