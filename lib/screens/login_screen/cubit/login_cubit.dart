import 'dart:developer';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:patient_app/core/api/services/get_my_information.dart';
import 'package:patient_app/core/models/patient_model.dart';
import '../../../core/api/services/login_service.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  String email = '';
  String password = '';
  IconData icon = Icons.remove_red_eye;
  bool obscureText = true;
  PatientModel patientModel = PatientModel();

  LoginCubit() : super(LoginInitial());

  Future<void> login() async {
    emit(LoginLoading());
    (await LoginService.login(email: email, password: password)).fold(
      (failure) => emit(LoginFailure(failureMsg: failure.errorMessege)),
      (loginModel) async {
        loginModel.id = int.parse(JwtDecoder.decode(loginModel.token)['sub']);
        await getMyInfo(userID: loginModel.id!);
        emit(LoginSuccess(loginModel: loginModel, patientModel: patientModel));
        if (loginModel.id != null) {
          log('Patient ID = ${patientModel.id}');
          log('Patient Address = ${patientModel.address}');
          log('Patient Name = ${patientModel.userModel?.firstName}');
        }
      },
    );
  }

  Future<void> getMyInfo({required int userID}) async {
    (await GetMyInformationService.getMyInfo(userID: userID)).fold(
      (failue) {
        log('There is an error in GetMyInfoService: ${failue.errorMessege}');
      },
      (success) {
        patientModel = success;
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
