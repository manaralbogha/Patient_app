import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/api/services/add_evaluation_service.dart';
import 'package:patient_app/core/api/services/favourite/add_to_favourite_service.dart';
import 'package:patient_app/core/api/services/favourite/delete_from_favourite_service.dart';
import 'package:patient_app/core/api/services/get_doctors_service.dart';
import 'package:patient_app/screens/patient_screens/doctor_details_screen/cubit/doctor_details_states.dart';

import '../../../../core/api/services/consultation/send_question_service.dart';
import '../../../../core/api/services/local/cache_helper.dart';
import '../../../../core/functions/custome_snack_bar.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsStates> {
  final String _adminToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWRjYzJjY2RmMDA3MGNlY2U0NmRkYmRmODUwYjc0YmIwNWE0ZDFmNDhkN2NhY2MyNmRhZDgwNGEzZThkOTcxY2ZmMzJmMDdjYTUxOTVhNzMiLCJpYXQiOjE2OTAwNTE1NjAuODM5NzU2LCJuYmYiOjE2OTAwNTE1NjAuODM5NzYsImV4cCI6MTcyMTY3Mzk2MC43MDMyNDgsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.V01I5ACEWzkp2g58jf4Dca9EX54mPflBQDxM3slYyvhGAKdXj06vaVao83F4xEvc8Up7BDO8cuqjh_zQ4Rw5M9Vlg0KqdEiAYTE7JHu1gnrHj8KceHqQe59mZsLzeB9GjwVs_Q0q-nsaV0qG9deLK7xM-lS2_FKDvXAkwgty97mjuZNWbIhnXvh5hbF_bYpkZsV7eKrd9m1i4pu9xvAoV6p1UxvV9JEtwVw4X89Z9s03tt1W1pHy59xW8XxUF_V9yGljFLjY_d6fgNc8vCG5LwlxA3avVPu4l3zy2LNymi6MQTxrgOB3SmdjqFEBGJFNk5QWi6Q67bVz5dnpeuI7IEMd9O3SBEMIejYchJ3doUd3DkcJbnGdpu_lN4NPdDiPUOptciXm76HHoUujHqfMMh-d9ryyEqxLD9fqJp3bSwT8pPiUUYrrc8ZxD6Ss0mds2v8pTE-XMRddvXanisqXNxE935D9RmuJ8SFffw9Qo3IAiXdoLeTVQARdRvaiR-iuOUfe-XOZ0JQwedjG0sH12dw3Yv4K0uzBeb_3Q3F2_1pu_33YF3C7mOqAQOZ2R89eglXE6d1cGEskFXQhvv-GSVo5M5UHOIokOvk4xezxJCPTkQhlLglu5JRdjywgbOoyHMPWr_Ztg-YHZHWMrNbYgtyn8mO-Zah9_xE1KMu0dr8';
  String favouriteText = 'Add To Favourite';
  Icon favouriteIcon = Icon(
    Icons.favorite_border,
    color: Colors.grey,
    size: 30.w,
  );
  int? ratingValue;
  bool visible = true;
  DoctorDetailsCubit() : super(DoctorDetailsInitial());

  void udpateImageState({required bool visibility}) {
    emit(UpdateImageState());
    visible = visibility;
    emit(DoctorDetailsInitial());
  }

  Future<void> addToFavourite(
      {required int doctorID, required String token}) async {
    emit(DoctorDetailsLoading());
    (await AddToFavouriteService.addToFavourite(
            doctorID: doctorID, token: token))
        .fold(
      (failure) {
        emit(DoctorDetaisFailure(failureMsg: failure.errorMessege));
      },
      (success) {
        favouriteIcon = Icon(
          Icons.favorite,
          color: Colors.red,
          size: 30.w,
        );
        favouriteText = 'Remove From Favourite';
        emit(FavouriteSuccessState());
      },
    );
  }

  Future<void> deleteFromFavourite(
      {required int favouriteID, required String token}) async {
    emit(DoctorDetailsLoading());
    (await DeleteFromFavouriteService.deleteFromFavourite(
            favouriteID: favouriteID, token: token))
        .fold(
      (failure) {
        emit(DoctorDetaisFailure(failureMsg: failure.errorMessege));
      },
      (success) {
        favouriteIcon = Icon(
          Icons.favorite_border,
          color: Colors.grey,
          size: 30.w,
        );
        favouriteText = 'Add To Favourite';
        emit(FavouriteSuccessState());
      },
    );
  }

  Future<void> addEvaluation({
    required int doctorID,
    required String token,
  }) async {
    if (ratingValue != null) {
      emit(DoctorDetailsLoading());
      (await AddEvaluationService.addEvaluation(
              doctorID: doctorID, value: ratingValue!, token: token))
          .fold(
        (failure) {
          emit(DoctorDetaisFailure(failureMsg: failure.errorMessege));
        },
        (success) {
          emit(AddEvaluteSuccess());
          GetDoctorsService.getDoctors(token: _adminToken);
        },
      );
    } else {
      log('ERRRRRRRRRRRROR: Rating Value is NULL');
    }
  }

  Future<void> addConsultation(BuildContext context,
      {required int doctorID, required String question}) async {
    emit(DoctorDetailsLoading());
    (await SendQuestionService.sendQuestion(
      doctorID: '$doctorID',
      question: question,
      token: CacheHelper.getData(key: 'Token'),
    ))
        .fold(
      (failure) {
        Navigator.pop(context);
        //emit(DoctorDetaisFailure(failureMsg: failure.errorMessege));
        emit(DoctorDetailsInitial());
        CustomeSnackBar.showSnackBar(
          context,
          msg: 'Something Went Wrong, Please Try Later',
          color: Colors.red,
        );
      },
      (success) {
        Navigator.pop(context);
        emit(DoctorDetailsInitial());
        CustomeSnackBar.showSnackBar(
          context,
          msg: 'Question Send Successfully',
          color: Colors.green,
        );
      },
    );
  }
}
