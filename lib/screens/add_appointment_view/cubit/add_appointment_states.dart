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
