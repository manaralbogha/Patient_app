import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patient_app/core/models/appointment_model.dart';
import '../../../errors/failures.dart';
import '../../http_api_services.dart';

abstract class GetAppointmentDetailsService {
  static Future<Either<Failure, AppointmentModel>> getAppointmentDetails(
      {required String token, required int id}) async {
    try {
      var data =
          await ApiServices.get(endPoint: 'viewAppointment', token: token);

      return right(data['item']);
    } catch (ex) {
      log('Exception: there is an error in getAppointmentDetails method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
