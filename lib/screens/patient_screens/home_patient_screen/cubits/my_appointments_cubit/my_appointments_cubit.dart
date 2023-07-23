import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_app/core/models/appointment_model.dart';
part 'my_appointments_states.dart';

class MyAppointmentsCubit extends Cubit<MyAppointmentsStates> {
  MyAppointmentsCubit() : super(MyAppointmentsInitial());
}
