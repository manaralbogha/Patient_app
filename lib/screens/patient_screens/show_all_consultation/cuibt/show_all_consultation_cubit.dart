import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_app/core/api/services/consultation/get_patient_consultations_service.dart';
import 'package:patient_app/screens/patient_screens/show_all_consultation/cuibt/show_all_consultation_states.dart';

class ShowAllConsultationCubit extends Cubit<ShowAllConsultationStates> {
  ShowAllConsultationCubit() : super(ShowAllConsultationInitial());

  Future<void> getAllPatientConsultations({
    required String token,
  }) async {
    emit(GetAllPatientConsultationsLoadingState());
    (await GetPatientConsultationsService.getPatientConsultations(token: token))
        .fold(
      (failure) {
        emit(
          GetAllPatientConsultationsErrorState(
              failureMsg: failure.errorMessege),
        );
      },
      (consultationModel) {
        emit(
          GetAllPatientConsultationsSuccessState(
              allConsulations: consultationModel),
        );
      },
    );
  }
}
