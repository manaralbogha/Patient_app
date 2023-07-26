import 'package:equatable/equatable.dart';
import 'package:patient_app/core/models/add_appointment_model.dart';

abstract class AddAppointmentStates extends Equatable {
  @override
  List<Object> get props => [];
}

class AddAppointmentInitial extends AddAppointmentStates {}

class SelectDayState extends AddAppointmentStates {}

class SelectTimeState extends AddAppointmentStates {}

class AddAppointmentFailureState extends AddAppointmentStates {
  final String failureMsg;

  AddAppointmentFailureState({required this.failureMsg});
}

class AddAppointmentLodgingState extends AddAppointmentStates {}

class AddAppointmentSuccessState extends AddAppointmentStates {
  final AddAppointmentModel addAppointmentModel;

  AddAppointmentSuccessState({required this.addAppointmentModel});
}

// class GetDoctorTimesState extends AddAppointmentStates {
//   final List<WorkDayModel> times;

//   GetDoctorTimesState({required this.times});

//   // List<WorkDayModel> getDoctorTimes({required int doctorID}) {
//   //   List<WorkDayModel> times = [];
//   //   for (WorkDayModel item in allTimes) {
//   //     if (doctorID == item.doctorID) {
//   //       times.add(item);
//   //     }
//   //   }
//   //   return times;
//   // }
// }
