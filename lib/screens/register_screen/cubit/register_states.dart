import 'package:equatable/equatable.dart';
import '../../../core/api/services/login_service.dart';

abstract class RegisterStates extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterStates {}

class RegisterLoading extends RegisterStates {}

class RegisterSelectGender extends RegisterStates {}

class RegisterSuccess extends RegisterStates {
  final LoginModel loginModel;

  RegisterSuccess({required this.loginModel});
}

class RegisterFailure extends RegisterStates {
  final String failureMsg;

  RegisterFailure({required this.failureMsg});
}

class AddSpecialtyState extends RegisterStates {}

class SelectTimeState extends RegisterStates {}

class ChangePasswordState extends RegisterStates {}

class SelectBirthDateState extends RegisterStates {}
