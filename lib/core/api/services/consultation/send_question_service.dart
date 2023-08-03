import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../errors/failures.dart';
import '../../http_api_services.dart';

abstract class SendQuestionService {
  static Future<Either<Failure, void>> sendQuestion({
    required String doctorID,
    required String question,
    required String token,
  }) async {
    try {
      await ApiServices.post(
        endPoint: 'question/store',
        body: {
          'question': question,
          'doctor_id': doctorID,
        },
        token: token,
      );

      return right(null);
    } catch (ex) {
      log('Exception: there is an error in sendQuestion method');
      log('\n $ex');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
