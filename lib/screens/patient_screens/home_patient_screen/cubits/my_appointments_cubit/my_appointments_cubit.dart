import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_app/core/api/services/appointment/delete_appointment.dart';
import 'package:patient_app/core/api/services/appointment/get_patient_appointments_service.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'package:patient_app/core/models/appointment_model.dart';
part 'my_appointments_states.dart';

class MyAppointmentsCubit extends Cubit<MyAppointmentsStates> {
  MyAppointmentsCubit() : super(MyAppointmentsInitial());

  // Future<void> getMyAppointments() async {
  //   emit(MyAppointmentsLoading());
  //   (await GetAppointmentsRequestsService.getAppointmentsRequestsService(
  //           token: CacheHelper.getData(key: 'Token')))
  //       .fold(
  //     (failure) {
  //       emit(MyAppointmentsFailure(failureMsg: failure.errorMessege));
  //     },
  //     (appointment) {
  //       emit(MyAppointmentsSuccess(appointments: appointment));
  //     },
  //   );
  // }

  Future<void> getMyAppointments({required int patientID}) async {
    emit(MyAppointmentsLoading());
    (await GetPatientAppointmentsService.getPatientAppointments(
            token: CacheHelper.getData(key: 'Token'), patientID: patientID))
        .fold(
      (failure) {
        emit(MyAppointmentsFailure(failureMsg: failure.errorMessege));
      },
      (appointment) {
        emit(MyAppointmentsSuccess(appointments: appointment));
      },
    );
  }

  Future<void> cancelAppointment({
    required appointmentID,
    required int patientID,
  }) async {
    (await DeleteAppointmentService.deleteAppointment(
      token: CacheHelper.getData(key: 'Token'),
      id: appointmentID,
    ))
        .fold(
      (failure) =>
          emit(MyAppointmentsFailure(failureMsg: failure.errorMessege)),
      (succes) => getMyAppointments(patientID: patientID),
    );
  }
}
