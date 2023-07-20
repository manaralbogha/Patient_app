import 'package:equatable/equatable.dart';
import 'package:patient_app/core/models/appointment_model.dart';

abstract class AppointmentsRequestsStates extends Equatable {
  @override
  List<Object> get props => [];
}

// class AppointmentsRequestsInitial extends AppointmentsRequestsStates {}

class AppointmentsRequestsLoading extends AppointmentsRequestsStates {}

class AppointmentsRequestsFailure extends AppointmentsRequestsStates {
  final String failureMsg;

  AppointmentsRequestsFailure({required this.failureMsg});
}

class AppointmentsRequestsSuccess extends AppointmentsRequestsStates {
  final List<AppointmentModel> appointments;

  AppointmentsRequestsSuccess({required this.appointments});
}
