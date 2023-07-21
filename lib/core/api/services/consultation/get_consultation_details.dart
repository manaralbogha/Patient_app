import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patient_app/core/models/consultation_model.dart';
import '../../../errors/failures.dart';
import '../../http_api_services.dart';

abstract class GetConsultationDetailsService {
  static Future<Either<Failure, ConsultationModel>> getConsultationDetails(
      {required String token, required int consultationID}) async {
    try {
      var data = await ApiServices.get(
          endPoint: 'consultation/show/$consultationID', token: token);

      return right(ConsultationModel.fromJson(data['consultaion']));
    } catch (ex) {
      log('Exception: there is an error in getConsultationDetails method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
