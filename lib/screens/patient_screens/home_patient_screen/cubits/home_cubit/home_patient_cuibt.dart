import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:patient_app/core/api/services/get_departments_service.dart';
import 'package:patient_app/core/api/services/get_patient_information.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'package:patient_app/core/api/services/log_out_service.dart';
import 'package:patient_app/core/models/department_model.dart';
import 'package:patient_app/core/models/patient_model.dart';
import 'package:patient_app/screens/login_screen/login_screen.dart';
import '../../../../../core/api/services/get_doctors_service.dart';
import '../../../../../core/utils/constants.dart';
import 'home_patient_states.dart';

class HomePatientCubit extends Cubit<HomePatientStates> {
  int? bottomNavigationBarIndex;
  PatientModel? patientModel;
  List<DepartmentModel> departments = [];
  int? departmentIndex;
  int? departmentID;

  HomePatientCubit() : super(HomePatientLoading());

  Future<void> getDoctorsAndDepartments() async {
    emit(HomePatientLoading());
    (await GetDoctorsService.getDoctors(token: Constants.adminToken)).fold(
      (failure) {
        emit(HomePatientFailure(failureMsg: failure.errorMessege));
      },
      (doctors) async {
        (await GetDepartmentsService.getDepartments(
                token: Constants.adminToken))
            .fold(
          (failure) {
            emit(HomePatientFailure(failureMsg: failure.errorMessege));
          },
          (departments) {
            this.departments = departments;
            emit(
              GetDoctorsAndDepartmentsSuccess(
                doctors: doctors,
                departments: departments,
              ),
            );
          },
        );
        //emit(GetDoctorsSuccess(doctors: doctors));
      },
    );
  }

  Future<void> fetchMyInfo() async {
    emit(HomePatientLoading());
    String token = await CacheHelper.getData(key: 'Token');
    int userID = int.parse(JwtDecoder.decode(token)['sub']);
    (await GetPatientInformationService.getUserInfo(userID: userID)).fold(
      (failure) {
        emit(HomePatientFailure(failureMsg: failure.errorMessege));
      },
      (patientModel) async {
        this.patientModel = patientModel;
        await getDoctorsAndDepartments();
      },
    );
  }

  // Future<void> getDepartments({required String token}) async {
  //   emit(HomePatientLoading());
  //   (await GetDepartmentsService.getDepartments(token: _adminToken)).fold(
  //     (failure) {
  //       emit(HomePatientFailure(failureMsg: failure.errorMessege));
  //     },
  //     (departments) {
  //       emit(GetDepartmentsSuccess(departments: departments));
  //     },
  //   );
  // }

  Future<void> logout(BuildContext context) async {
    emit(HomePatientLoading());
    (await LogOutService.logout(token: await CacheHelper.getData(key: 'Token')))
        .fold(
      (failure) {
        emit(HomePatientFailure(failureMsg: failure.errorMessege));
      },
      (success) async {
        await CacheHelper.deletData(key: 'Token');
        await CacheHelper.deletData(key: 'Role');
        emit(LogOutState());
        // ignore: use_build_context_synchronously
        Navigator.popAndPushNamed(context, LoginView.route);
      },
    );
  }

  Future<void> viewDoctorsForDebarment({
    required int departmentsId,
    required String departmentImage,
  }) async {
    departmentID = departmentsId;
    await getDoctorsAndDepartments();
  }
}
