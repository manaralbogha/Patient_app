import 'dart:developer';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_app/core/models/register_model.dart';
import 'package:patient_app/screens/register_screen/cubit/register_states.dart';
import '../../../core/api/services/local/cache_helper.dart';
import '../../../core/api/services/register_service.dart';
import '../../../core/functions/custome_snack_bar.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  bool obscureText = true;
  IconData icon = Icons.remove_red_eye;
  final formKey = GlobalKey<FormState>();
  RegisterModel registerModel = RegisterModel();
  Color male = Colors.grey[400]!;
  Color maleTextColor = Colors.white;
  Color female = Colors.grey[400]!;
  Color femaleTextColor = Colors.white;
  String date = '';

  RegisterCubit() : super(RegisterInitial());

  Future<void> setFcmToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    registerModel.fcmToken = fcmToken;
    log(fcmToken.toString());
  }

  Future<void> register(BuildContext context) async {
    await setFcmToken().then(
      (value) {
        log('FCM Token = ${registerModel.fcmToken}');
      },
    );
    emit(RegisterLoading());
    (await RegisterService.registerPatient(registerModel: registerModel)).fold(
      (failure) {
        emit(RegisterFailure(failureMsg: failure.errorMessege));
      },
      (loginModel) {
        emit(RegisterSuccess(loginModel: loginModel));
        CacheHelper.saveData(key: 'Token', value: loginModel.token);
        CacheHelper.saveData(key: 'Role', value: loginModel.role);
        // Navigator.popAndPushNamed(context, AddAppointmentView.route);
        CustomeSnackBar.showSnackBar(
          context,
          msg: 'Account Created Successfully',
          color: Colors.green.withOpacity(.7),
        );
      },
    );
  }

  void changePasswordState() {
    emit(RegisterInitial());
    obscureText = !obscureText;
    if (!obscureText) {
      icon = FontAwesomeIcons.solidEyeSlash;
    } else {
      icon = FontAwesomeIcons.solidEye;
    }
    emit(ChangePasswordState());
  }

  void selectGender({required String type}) {
    registerModel.gender = type;
    if (type == 'Male') {
      male = Colors.blue.withOpacity(.75);
      female = Colors.grey[400]!;
      // maleTextColor = defaultColor;
      // femaleTextColor = Colors.white;
      emit(RegisterInitial());
    } else {
      female = Colors.pink.withOpacity(.75);
      male = Colors.grey[400]!;
      maleTextColor = Colors.white;
      // femaleTextColor = defaultColor;
      emit(RegisterSelectGender());
    }
  }

  void selectBirthDate() {
    emit(RegisterInitial());
    if (date.length >= 10) {
      registerModel.birthDate = date.substring(0, 10);
    }
    emit(SelectBirthDateState());
  }
}
