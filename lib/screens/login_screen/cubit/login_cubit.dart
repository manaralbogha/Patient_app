import 'dart:developer';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../core/api/services/login_service.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  String email = '';
  String password = '';
  IconData icon = Icons.remove_red_eye;
  bool obscureText = true;

  LoginCubit() : super(LoginInitial());

  Future<void> login() async {
    emit(LoginLoading());
    (await LoginService.login(email: email, password: password)).fold(
      (failure) => emit(LoginFailure(failureMsg: failure.errorMessege)),
      (loginModel) {
        loginModel.id = int.parse(JwtDecoder.decode(loginModel.token)['sub']);
        emit(LoginSuccess(loginModel: loginModel));
        log('\n UserID = ${loginModel.id}');
      },
    );
  }

  void changePasswordState() {
    obscureText = !obscureText;
    if (!obscureText) {
      icon = FontAwesomeIcons.solidEyeSlash;
      emit(LoginInitial());
    } else {
      icon = FontAwesomeIcons.solidEye;
      emit(ChangePasswordState());
    }
  }
}
