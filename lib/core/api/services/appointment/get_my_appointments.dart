import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patient_app/core/models/appointment_model.dart';
import '../../../errors/failures.dart';
import '../../http_api_services.dart';

abstract class GetMyAppointmentsService {
  static Future<Either<Failure, List<AppointmentModel>>> getMyAppointments(
      {required String token}) async {
    try {
      var data =
          await ApiServices.get(endPoint: 'storeAppointment', token: token);
      List<AppointmentModel> myAppointments = [];
      for (var item in data['Appointment']) {
        myAppointments.add(AppointmentModel.fromJson(item));
      }
      return right(myAppointments);
    } catch (ex) {
      log('Exception: there is an error in getMyAppointments method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
