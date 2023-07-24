import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:patient_app/core/api/services/get_departments_service.dart';
import 'package:patient_app/core/api/services/get_my_information.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'package:patient_app/core/api/services/log_out_service.dart';
import 'package:patient_app/core/models/patient_model.dart';
import 'package:patient_app/screens/login_screen/login_screen.dart';
import '../../../../../core/api/services/get_doctors_service.dart';
import 'home_patient_states.dart';

class HomePatientCubit extends Cubit<HomePatientStates> {
  final String _adminToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWRjYzJjY2RmMDA3MGNlY2U0NmRkYmRmODUwYjc0YmIwNWE0ZDFmNDhkN2NhY2MyNmRhZDgwNGEzZThkOTcxY2ZmMzJmMDdjYTUxOTVhNzMiLCJpYXQiOjE2OTAwNTE1NjAuODM5NzU2LCJuYmYiOjE2OTAwNTE1NjAuODM5NzYsImV4cCI6MTcyMTY3Mzk2MC43MDMyNDgsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.V01I5ACEWzkp2g58jf4Dca9EX54mPflBQDxM3slYyvhGAKdXj06vaVao83F4xEvc8Up7BDO8cuqjh_zQ4Rw5M9Vlg0KqdEiAYTE7JHu1gnrHj8KceHqQe59mZsLzeB9GjwVs_Q0q-nsaV0qG9deLK7xM-lS2_FKDvXAkwgty97mjuZNWbIhnXvh5hbF_bYpkZsV7eKrd9m1i4pu9xvAoV6p1UxvV9JEtwVw4X89Z9s03tt1W1pHy59xW8XxUF_V9yGljFLjY_d6fgNc8vCG5LwlxA3avVPu4l3zy2LNymi6MQTxrgOB3SmdjqFEBGJFNk5QWi6Q67bVz5dnpeuI7IEMd9O3SBEMIejYchJ3doUd3DkcJbnGdpu_lN4NPdDiPUOptciXm76HHoUujHqfMMh-d9ryyEqxLD9fqJp3bSwT8pPiUUYrrc8ZxD6Ss0mds2v8pTE-XMRddvXanisqXNxE935D9RmuJ8SFffw9Qo3IAiXdoLeTVQARdRvaiR-iuOUfe-XOZ0JQwedjG0sH12dw3Yv4K0uzBeb_3Q3F2_1pu_33YF3C7mOqAQOZ2R89eglXE6d1cGEskFXQhvv-GSVo5M5UHOIokOvk4xezxJCPTkQhlLglu5JRdjywgbOoyHMPWr_Ztg-YHZHWMrNbYgtyn8mO-Zah9_xE1KMu0dr8';

  int? bottomNavigationBarIndex;
  PatientModel? patientModel;
  HomePatientCubit() : super(HomePatientInitial());

  Future<void> getDoctors() async {
    emit(HomePatientLoading());
    (await GetDoctorsService.getDoctors(token: _adminToken)).fold(
      (failure) {
        emit(HomePatientFailure(failureMsg: failure.errorMessege));
      },
      (doctors) {
        emit(GetDoctorsSuccess(doctors: doctors));
      },
    );
  }

  Future<void> fetchMyInfo() async {
    emit(HomePatientLoading());
    String token = await CacheHelper.getData(key: 'Token');
    int userID = int.parse(JwtDecoder.decode(token)['sub']);
    (await GetMyInformationService.getMyInfo(userID: userID)).fold(
      (failure) {
        emit(HomePatientFailure(failureMsg: failure.errorMessege));
      },
      (patientModel) async {
        this.patientModel = patientModel;
        await getDoctors();
      },
    );
  }

  Future<void> getDepartments({required String token}) async {
    emit(HomePatientLoading());
    (await GetDepartmentsService.getDepartments(token: _adminToken)).fold(
      (failure) {
        emit(HomePatientFailure(failureMsg: failure.errorMessege));
      },
      (departments) {
        emit(GetDepartmentsSuccess(departments: departments));
      },
    );
  }

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
}
