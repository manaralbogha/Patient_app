import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patient_app/core/models/patient_model.dart';
import '../../errors/failures.dart';
import '../../utils/constants.dart';
import '../http_api_services.dart';

abstract class GetPatientInformationService {
  static Future<Either<Failure, PatientModel>> getUserInfo({
    required int userID,
  }) async {
    try {
      var data = await ApiServices.post(
        endPoint: 'viewPatient',
        body: {
          'user_id': '$userID',
        },
        token: Constants.adminToken,
      );

      return right(PatientModel.fromJson(data['Patient']));
    } catch (ex) {
      log('Exception: there is an error in getMyInfo method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
