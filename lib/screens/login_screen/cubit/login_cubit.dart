import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_app/core/models/patient_model.dart';
import '../../../core/api/services/login_service.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  String email = '';
  String password = '';
  IconData icon = Icons.remove_red_eye;
  bool obscureText = true;
  PatientModel patientModel = PatientModel();
  final formKey = GlobalKey<FormState>();

  LoginCubit() : super(LoginInitial());

  Future<void> login() async {
    emit(LoginLoading());
    (await LoginService.login(email: email, password: password)).fold(
      (failure) => emit(LoginFailure(failureMsg: failure.errorMessege)),
      (loginModel) => emit(LoginSuccess(loginModel: loginModel)),
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
