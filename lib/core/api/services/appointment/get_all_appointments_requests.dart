import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patient_app/core/models/appointment_model.dart';
import '../../../errors/failures.dart';
import '../../http_api_services.dart';

abstract class GetAppointmentsRequestsService {
  static Future<Either<Failure, List<AppointmentModel>>>
      getAppointmentsRequestsService({required String token}) async {
    try {
      var data =
          await ApiServices.get(endPoint: 'indexAppointment', token: token);
      List<AppointmentModel> myAppointments = [];
      for (var item in data['Appointment']) {
        myAppointments.add(AppointmentModel<int>.fromJson(item));
      }
      return right(myAppointments);
    } catch (ex) {
      log('Exception: there is an error in getAppointmentsRequestsService method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
