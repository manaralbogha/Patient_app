// ignore_for_file: missing_required_param, unused_local_variable

import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patient_app/core/models/doctor_model.dart';
import '../../../errors/failures.dart';
import '../../http_api_services.dart';

abstract class GetMyFavouritedService {
  static Future<Either<Failure, List<DoctorModel>>> getFavourite({
    required String token,
  }) async {
    try {
      var data = await ApiServices.get(
        endPoint: 'favorite/index',
        token: token,
      );
      List<DoctorModel> doctors = [];
      for (var item in data['session']) {
        int index = 0;

        var doctorData = await ApiServices.post(
          endPoint: 'viewDoctor',
          body: {
            'user_id': '${item['user_id']}',
          },
        );
        doctors.add(DoctorModel.fromJson(doctorData['doctor']));
        index += 1;
      }
      return right(doctors);
    } catch (ex) {
      log('Exception: there is an error in getFavourite method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
