import 'package:equatable/equatable.dart';

import '../../../core/api/services/login_service.dart';

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

  LoginSuccess({required this.loginModel});
}

class ChangePasswordState extends LoginStates {}
