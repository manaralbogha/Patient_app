import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/api/services/add_evaluation_service.dart';
import 'package:patient_app/core/api/services/favourite/add_to_favourite_service.dart';
import 'package:patient_app/core/api/services/favourite/delete_from_favourite_service.dart';
import 'package:patient_app/screens/patient_screens/doctor_details_screen/cubit/doctor_details_states.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsStates> {
  String favouriteText = 'Add To Favourite';
  Icon favouriteIcon = Icon(
    Icons.favorite_border,
    color: Colors.grey,
    size: 30.w,
  );
  DoctorDetailsCubit() : super(DoctorDetailsInitial());

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
    required int value,
    required String token,
  }) async {
    emit(DoctorDetailsLoading());
    (await AddEvaluationService.addEvaluation(
            doctorID: doctorID, value: value, token: token))
        .fold(
      (failure) {
        emit(DoctorDetaisFailure(failureMsg: failure.errorMessege));
      },
      (success) {
        emit(AddEvaluteSuccess());
      },
    );
  }
}
