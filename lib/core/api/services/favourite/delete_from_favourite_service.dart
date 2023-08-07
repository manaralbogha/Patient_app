import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../errors/failures.dart';
import '../../http_api_services.dart';

abstract class DeleteFromFavouriteService {
  static Future<Either<Failure, void>> deleteFromFavourite(
      {required String token, required int doctorID}) async {
    try {
      await ApiServices.post(
        endPoint: 'favorite/deleteOnDoctor',
        body: {'doctor_id': '$doctorID'},
        token: token,
      );

      return right(null);
    } catch (ex) {
      log('Exception: there is an error in deleteFromFavourite method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
