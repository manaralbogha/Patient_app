import 'package:equatable/equatable.dart';

abstract class AddAppointmentStates extends Equatable {
  @override
  List<Object> get props => [];
}

class AddAppointmentInitial extends AddAppointmentStates {}

class SelectDayState extends AddAppointmentStates {}
