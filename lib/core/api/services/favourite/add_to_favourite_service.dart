import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../errors/failures.dart';
import '../../http_api_services.dart';

abstract class AddToFavouriteService {
  static Future<Either<Failure, void>> addToFavourite({
    required int doctorID,
    required String token,
  }) async {
    try {
      await ApiServices.post(
        endPoint: 'favorite/store',
        body: {
          'doctor_id': '$doctorID',
        },
        token: token,
      );

      return right(null);
    } catch (ex) {
      log('Exception: there is an error in addToFavourite method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
