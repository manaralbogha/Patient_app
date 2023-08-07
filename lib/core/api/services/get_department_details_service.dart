import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patient_app/core/utils/constants.dart';
import '../../errors/failures.dart';
import '../../models/department_model.dart';
import '../http_api_services.dart';

abstract class GetDepartmentDetailsService {
  static Future<Either<Failure, DepartmentModel>> getDepartmentDetails(
      {required int id}) async {
    try {
      var data = await ApiServices.post(
        endPoint: 'viewDepartment',
        token: Constants.adminToken,
        body: {'id': '$id'},
      );

      return right(DepartmentModel.fromJson(data['item']));
    } catch (ex) {
      log('Exception: there is an error in getDepartmentDetails method');
      log(ex.toString());
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
