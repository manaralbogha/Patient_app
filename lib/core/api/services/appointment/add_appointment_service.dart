import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patient_app/core/api/http_api_services.dart';
import 'package:patient_app/core/errors/failures.dart';
import 'package:patient_app/core/models/add_appointment_model.dart';

abstract class AddAppointmentService {
  static Future<Either<Failure, void>> addAppointment({
    required String token,
    required AddAppointmentModel addAppointmentModel,
  }) async {
    try {
      await ApiServices.post(
        endPoint: 'storeAppointment',
        body: {
          'date': addAppointmentModel.date,
          'time': addAppointmentModel.time,
          'description': addAppointmentModel.description,
          'department_id': addAppointmentModel.departmentId,
          'doctor_id': addAppointmentModel.doctorIid,
        },
        token: token,
      );

      return right(null);
    } catch (ex) {
      log('Exception: there is an error in addAppointment method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
