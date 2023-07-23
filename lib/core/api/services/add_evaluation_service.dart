import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../errors/failures.dart';
import '../http_api_services.dart';

abstract class AddEvaluationService {
  static Future<Either<Failure, void>> addEvaluation({
    required int doctorID,
    required int value,
    required String token,
  }) async {
    try {
      await ApiServices.post(
        endPoint: 'evaluation/store',
        body: {
          'doctor_id': '$doctorID',
          'value': '$value',
        },
        token: token,
      );

      return right(null);
    } catch (ex) {
      log('Exception: there is an error in addEvaluation method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
