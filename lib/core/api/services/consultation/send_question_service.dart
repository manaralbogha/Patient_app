import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../errors/failures.dart';
import '../../../models/consultation_model.dart';
import '../../http_api_services.dart';

abstract class SendQuestionService {
  static Future<Either<Failure, ConsultationModel>> sendQuestion({
    required int doctorID,
    required String question,
    required String token,
  }) async {
    try {
      var data = await ApiServices.post(
        endPoint: 'question/store',
        body: {
          'question': question,
          'doctor_id': doctorID,
        },
        token: token,
      );

      return right(ConsultationModel.fromJson(data));
    } catch (ex) {
      log('Exception: there is an error in sendQuestion method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
