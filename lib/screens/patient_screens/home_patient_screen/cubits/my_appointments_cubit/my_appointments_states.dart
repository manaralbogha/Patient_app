part of 'my_appointments_cubit.dart';

abstract class MyAppointmentsStates extends Equatable {
  const MyAppointmentsStates();

  @override
  List<Object> get props => [];
}

class MyAppointmentsInitial extends MyAppointmentsStates {}

class MyAppointmentsLoading extends MyAppointmentsStates {}

class MyAppointmentsFailure extends MyAppointmentsStates {
  final String failureMsg;

  const MyAppointmentsFailure({required this.failureMsg});
}

class MyAppointmentsSuccess extends MyAppointmentsStates {
  final List<AppointmentModel> appointments;

  const MyAppointmentsSuccess({required this.appointments});

  // List<AppointmentModel> getMyAppointments({required int patientID}) {
  //   List<AppointmentModel> myAppointments = [];
  //   for (AppointmentModel item in appointments) {
  //     if (patientID == item.patientId) {
  //       myAppointments.add(item);
  //     }
  //   }
  //   return myAppointments;
  // }
}
