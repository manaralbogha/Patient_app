// ignore_for_file: missing_required_param

import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../errors/failures.dart';
import '../../models/register_model.dart';
import '../http_api_services.dart';
import 'login_service.dart';

abstract class RegisterService {
  static Future<Either<Failure, LoginModel>> registerPatient(
      {required RegisterModel registerModel}) async {
    try {
      var data = await ApiServices.post(
        endPoint: 'registerPatient',
        body: {
          'email': registerModel.email,
          'first_name': registerModel.firstName,
          'last_name': registerModel.lastName,
          'password': registerModel.password,
          'phone_num': registerModel.phoneNum,
          'birth_date': registerModel.birthDate,
          'gender': registerModel.gender,
          'address': registerModel.address,
          'FCMToken': registerModel.fcmToken,
        },
      );

      return right(LoginModel.fromJson(data));
    } catch (ex) {
      log('Exception: there is an error in registerPatient method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
