import 'package:equatable/equatable.dart';

import '../../../core/api/services/login_service.dart';
import '../../../core/models/patient_model.dart';

abstract class LoginStates extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginFailure extends LoginStates {
  final String failureMsg;

  LoginFailure({required this.failureMsg});
}

class LoginSuccess extends LoginStates {
  final LoginModel loginModel;
  final PatientModel patientModel;

  LoginSuccess({required this.loginModel, required this.patientModel});
}

class ChangePasswordState extends LoginStates {}
