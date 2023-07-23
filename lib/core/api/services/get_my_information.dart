import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patient_app/core/models/patient_model.dart';
import '../../errors/failures.dart';
import '../http_api_services.dart';

abstract class GetMyInformationService {
  static const String _adminToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWRjYzJjY2RmMDA3MGNlY2U0NmRkYmRmODUwYjc0YmIwNWE0ZDFmNDhkN2NhY2MyNmRhZDgwNGEzZThkOTcxY2ZmMzJmMDdjYTUxOTVhNzMiLCJpYXQiOjE2OTAwNTE1NjAuODM5NzU2LCJuYmYiOjE2OTAwNTE1NjAuODM5NzYsImV4cCI6MTcyMTY3Mzk2MC43MDMyNDgsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.V01I5ACEWzkp2g58jf4Dca9EX54mPflBQDxM3slYyvhGAKdXj06vaVao83F4xEvc8Up7BDO8cuqjh_zQ4Rw5M9Vlg0KqdEiAYTE7JHu1gnrHj8KceHqQe59mZsLzeB9GjwVs_Q0q-nsaV0qG9deLK7xM-lS2_FKDvXAkwgty97mjuZNWbIhnXvh5hbF_bYpkZsV7eKrd9m1i4pu9xvAoV6p1UxvV9JEtwVw4X89Z9s03tt1W1pHy59xW8XxUF_V9yGljFLjY_d6fgNc8vCG5LwlxA3avVPu4l3zy2LNymi6MQTxrgOB3SmdjqFEBGJFNk5QWi6Q67bVz5dnpeuI7IEMd9O3SBEMIejYchJ3doUd3DkcJbnGdpu_lN4NPdDiPUOptciXm76HHoUujHqfMMh-d9ryyEqxLD9fqJp3bSwT8pPiUUYrrc8ZxD6Ss0mds2v8pTE-XMRddvXanisqXNxE935D9RmuJ8SFffw9Qo3IAiXdoLeTVQARdRvaiR-iuOUfe-XOZ0JQwedjG0sH12dw3Yv4K0uzBeb_3Q3F2_1pu_33YF3C7mOqAQOZ2R89eglXE6d1cGEskFXQhvv-GSVo5M5UHOIokOvk4xezxJCPTkQhlLglu5JRdjywgbOoyHMPWr_Ztg-YHZHWMrNbYgtyn8mO-Zah9_xE1KMu0dr8';
  static Future<Either<Failure, PatientModel>> getMyInfo({
    required int userID,
  }) async {
    try {
      var data = await ApiServices.post(
        endPoint: 'viewPatient',
        body: {
          'user_id': '$userID',
        },
        token: _adminToken,
      );

      return right(PatientModel.fromJson(data['Patient']));
    } catch (ex) {
      log('Exception: there is an error in getMyInfo method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
