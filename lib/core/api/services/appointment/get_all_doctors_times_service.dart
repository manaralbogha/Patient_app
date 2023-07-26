import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patient_app/core/models/work_day_model.dart';
import '../../../errors/failures.dart';
import '../../http_api_services.dart';

abstract class GetAllDoctorsTimes {
  static Future<Either<Failure, List<WorkDayModel>>> getAllDoctorsTimes(
      {required String token}) async {
    try {
      List<WorkDayModel> times = [];
      var data = await ApiServices.get(endPoint: 'indexWorkDay', token: token);
      for (var item in data['data']) {
        times.add(WorkDayModel.fromJson(item));
      }

      return right(times);
    } catch (ex) {
      log('Exception: there is an error in getAllDoctorsTimes method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
