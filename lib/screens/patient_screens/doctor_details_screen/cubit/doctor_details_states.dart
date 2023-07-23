import 'package:equatable/equatable.dart';

abstract class DoctorDetailsStates extends Equatable {
  @override
  List<Object> get props => [];
}

class DoctorDetailsInitial extends DoctorDetailsStates {}

class DoctorDetailsLoading extends DoctorDetailsStates {}

class DoctorDetaisFailure extends DoctorDetailsStates {
  final String failureMsg;

  DoctorDetaisFailure({required this.failureMsg});
}

class FavouriteSuccessState extends DoctorDetailsStates {}

class AddEvaluteSuccess extends DoctorDetailsStates {}

class UpdateImageState extends DoctorDetailsStates {}
