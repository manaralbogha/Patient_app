import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patient_app/core/api/http_api_services.dart';
import 'package:patient_app/core/errors/failures.dart';
import 'package:patient_app/core/models/handle_appointment_model.dart';
import 'package:patient_app/core/models/message_model.dart';

abstract class HandleAppointmentServic {
  static Future<Either<Failure, MessageModel>> handleAppointment({
    required String token,
    required HandleAppointmentModel model,
  }) async {
    try {
      var data = await ApiServices.post(
        endPoint: 'AppointmentHandle',
        body: {
          'date': model.date,
          'time': model.time,
          'reason': model.reason,
          'status': model.status,
          'id': model.id,
        },
        token: token,
      );

      return right(MessageModel.fromJson(data));
    } catch (ex) {
      log('Exception: there is an error in handleAppointment method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
