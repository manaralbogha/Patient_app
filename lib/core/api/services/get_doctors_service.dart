import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../errors/failures.dart';
import '../../models/doctor_model.dart';
import '../http_api_services.dart';

abstract class GetDoctorsService {
  static Future<Either<Failure, List<DoctorModel>>> getDoctors(
      {required String token}) async {
    try {
      var data = await ApiServices.get(endPoint: 'indexDoctor', token: token);
      List<DoctorModel> doctors = [];
      for (var item in data['Doctor']) {
        doctors.add(DoctorModel.fromJson(item));
      }
      return right(doctors);
    } catch (ex) {
      log('Exception: there is an error in getDoctors method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
