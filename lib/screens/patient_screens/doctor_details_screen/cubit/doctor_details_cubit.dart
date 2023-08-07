import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/api/services/add_evaluation_service.dart';
import 'package:patient_app/core/api/services/favourite/add_to_favourite_service.dart';
import 'package:patient_app/core/api/services/favourite/check_is_favourited.dart';
import 'package:patient_app/core/api/services/favourite/delete_from_favourite_service.dart';
import 'package:patient_app/core/api/services/get_doctor_details_service.dart';
import 'package:patient_app/core/api/services/get_doctors_service.dart';
import 'package:patient_app/screens/patient_screens/doctor_details_screen/cubit/doctor_details_states.dart';
import '../../../../core/api/services/consultation/send_question_service.dart';
import '../../../../core/api/services/local/cache_helper.dart';
import '../../../../core/functions/custome_snack_bar.dart';
import '../../../../core/utils/constants.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsStates> {
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
        emit(CheckFavouriteState());
      },
    );
  }

  Future<void> deleteFromFavourite(
      {required int doctorID, required String token}) async {
    emit(DoctorDetailsLoading());
    (await DeleteFromFavouriteService.deleteFromFavourite(
            doctorID: doctorID, token: token))
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
          GetDoctorsService.getDoctors(token: Constants.adminToken);
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

  Future<void> checkIsFavourited(
      {required String token, required int doctorID}) async {
    emit(DoctorDetailsLoading());
    (await CheckIsFavouritedService.checkIsFavourited(
            doctorID: doctorID, token: token))
        .fold(
      (failure) {
        emit(DoctorDetaisFailure(failureMsg: failure.errorMessege));
      },
      (isFavourited) {
        if (isFavourited) {
          favouriteText = 'Remove From Favourite';
          favouriteIcon = Icon(
            Icons.favorite,
            color: Colors.red,
            size: 30.w,
          );
        } else {
          favouriteText = 'Add To Favourite';
          favouriteIcon = Icon(
            Icons.favorite_border,
            color: Colors.grey,
            size: 30.w,
          );
        }
        emit(CheckFavouriteState());
      },
    );
  }

  Future<void> getDoctorDetails({required int userID}) async {
    (await GetDoctorDetailsService.getDoctorDetails(userID: userID)).fold(
      (failure) {
        emit(DoctorDetaisFailure(failureMsg: failure.errorMessege));
      },
      (doctorModel) {
        emit(FetchDoctorDetailsSuccess(doctorModel: doctorModel));
      },
    );
  }
}
