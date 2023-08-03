import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patient_app/core/models/appointment_model.dart';
import '../../../errors/failures.dart';
import '../../http_api_services.dart';

abstract class GetPatientAppointmentsService {
  static Future<Either<Failure, List<AppointmentModel<int>>>>
      getPatientAppointments(
          {required String token, required int patientID}) async {
    try {
      var data = await ApiServices.post(
          endPoint: 'indexAppointmentPatient',
          token: token,
          body: {'patient_id': '$patientID'});
      List<AppointmentModel<int>> myAppointments = [];
      for (var item in data['Appointment']) {
        myAppointments.add(AppointmentModel<int>.fromJson(item));
      }
      return right(myAppointments);
    } catch (ex) {
      log('Exception: there is an error in getPatientAppointments method');
      log(ex.toString());
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
