import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_app/core/api/services/appointment/get_all_appointments_requests.dart';
import 'appointments_requests_states.dart';

class AppointmentsRequestsCubit extends Cubit<AppointmentsRequestsStates> {
  AppointmentsRequestsCubit() : super(AppointmentsRequestsLoading());

  Future<void> getAppointmentsRequests({required String token}) async {
    (await GetAllAppointmentsRequestsService.getAppointmentsRequestsService(
            token: token))
        .fold(
      (failure) {
        emit(AppointmentsRequestsFailure(failureMsg: failure.errorMessege));
      },
      (appointments) {
        emit(AppointmentsRequestsSuccess(appointments: appointments));
      },
    );
  }
}
