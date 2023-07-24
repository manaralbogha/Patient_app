import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_app/core/api/services/appointment/get_all_appointments_requests.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'package:patient_app/core/models/appointment_model.dart';
part 'my_appointments_states.dart';

class MyAppointmentsCubit extends Cubit<MyAppointmentsStates> {
  MyAppointmentsCubit() : super(MyAppointmentsInitial());

  Future<void> getMyAppointments() async {
    emit(MyAppointmentsLoading());
    (await GetAppointmentsRequestsService.getAppointmentsRequestsService(
            token: CacheHelper.getData(key: 'Token')))
        .fold(
      (failure) {
        emit(MyAppointmentsFailure(failureMsg: failure.errorMessege));
      },
      (appointment) {
        emit(MyAppointmentsSuccess(appointments: appointment));
      },
    );
  }
}
