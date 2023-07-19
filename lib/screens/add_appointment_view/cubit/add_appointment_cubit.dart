import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_app/screens/add_appointment_view/cubit/add_appointment_states.dart';

class AddAppointmentCubit extends Cubit<AddAppointmentStates> {
  AddAppointmentCubit() : super(AddAppointmentInitial());
}
