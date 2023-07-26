import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patient_app/core/api/http_api_services.dart';
import 'package:patient_app/core/errors/failures.dart';
import 'package:patient_app/core/models/message_model.dart';

abstract class DeleteAppointmentService {
  static Future<Either<Failure, MessageModel>> deleteAppointment({
    required String token,
    required int id,
  }) async {
    try {
      var data = await ApiServices.post(
        endPoint: 'deleteAppointment',
        body: {
          'id': '$id',
        },
        token: token,
      );

      return right(MessageModel.fromJson(data));
    } catch (ex) {
      log('Exception: there is an error in deleteAppointment method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
