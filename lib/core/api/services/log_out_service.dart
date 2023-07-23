import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../errors/failures.dart';
import '../http_api_services.dart';

abstract class LogOutService {
  static Future<Either<Failure, void>> logout({required String token}) async {
    try {
      await ApiServices.get(endPoint: 'logout', token: token);

      return right(null);
    } catch (ex) {
      log('Exception: there is an error in logout method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
