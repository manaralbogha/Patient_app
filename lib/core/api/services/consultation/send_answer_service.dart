import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../errors/failures.dart';
import '../../../models/consultation_model.dart';
import '../../http_api_services.dart';

abstract class SendAnswerService {
  static Future<Either<Failure, ConsultationModel>> sendAnswer({
    required int consultationID,
    required String answer,
    required String token,
  }) async {
    try {
      var data = await ApiServices.post(
        endPoint: 'answer/store/$consultationID',
        body: {
          'answer': answer,
        },
        token: token,
      );

      return right(ConsultationModel.fromJson(data));
    } catch (ex) {
      log('Exception: there is an error in sendAnswer method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
