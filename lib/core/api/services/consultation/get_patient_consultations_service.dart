import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patient_app/core/models/consultation_model.dart';
import '../../../errors/failures.dart';
import '../../http_api_services.dart';

abstract class GetPatientConsultationsService {
  static Future<Either<Failure, List<ConsultationModel>>>
      getPatientConsultations({required String token}) async {
    try {
      var data =
          await ApiServices.get(endPoint: 'consultation/index', token: token);
      List<ConsultationModel> consultations = [];
      for (var item in data['consultaion']) {
        consultations.add(ConsultationModel.fromJson(item));
      }
      return right(consultations);
    } catch (ex) {
      log('Exception: there is an error in getPatientConsultations method');
      log(ex.toString());
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
