import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../errors/failures.dart';
import '../../http_api_services.dart';

abstract class CheckIsFavouritedService {
  static Future<Either<Failure, bool>> checkIsFavourited({
    required int doctorID,
    required String token,
  }) async {
    try {
      var data = await ApiServices.post(
        endPoint: 'favorite/isfavorated',
        body: {
          'doctor_id': '$doctorID',
        },
        token: token,
      );
      bool isFavourited = data['isFavorated'];

      return right(isFavourited);
    } catch (ex) {
      log('Exception: there is an error in checkIsFavourited method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
