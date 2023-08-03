// ignore_for_file: missing_required_param

import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patient_app/core/models/doctor_model.dart';
import '../../errors/failures.dart';
import '../http_api_services.dart';

abstract class GetDoctorDetailsService {
  static Future<Either<Failure, DoctorModel>> getDoctorDetails({
    required int userID,
  }) async {
    try {
      var data = await ApiServices.post(
        endPoint: 'viewDoctor',
        body: {
          'user_id': '$userID',
        },
      );

      return right(DoctorModel.fromJson(data['doctor']));
    } catch (ex) {
      log('Exception: there is an error in getDoctorDetails method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
