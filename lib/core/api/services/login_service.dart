// ignore_for_file: missing_required_param

import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../errors/failures.dart';
import '../http_api_services.dart';

abstract class LoginService {
  static Future<Either<Failure, LoginModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      var data = await ApiServices.post(
        endPoint: 'login',
        body: {
          'email': email,
          'password': password,
        },
      );

      return right(LoginModel.fromJson(data));
    } catch (ex) {
      log('Exception: there is an error in login method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}

class LoginModel {
  final String token;
  final String role;

  LoginModel({required this.token, required this.role});

  factory LoginModel.fromJson(Map<String, dynamic> jsonData) {
    return LoginModel(token: jsonData['token'], role: jsonData['role']);
  }
}
