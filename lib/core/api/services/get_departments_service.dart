import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../errors/failures.dart';
import '../../models/department_model.dart';
import '../http_api_services.dart';

abstract class GetDepartmentsService {
  static Future<Either<Failure, List<DepartmentModel>>> getDepartments(
      {required String token}) async {
    try {
      var data =
          await ApiServices.get(endPoint: 'indexDepartment', token: token);
      List<DepartmentModel> departments = [];
      for (var item in data['Department']) {
        departments.add(DepartmentModel.fromJson(item));
      }
      return right(departments);
    } catch (ex) {
      log('Exception: there is an error in getDepartments method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
