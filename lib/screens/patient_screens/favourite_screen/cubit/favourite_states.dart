import 'package:equatable/equatable.dart';
import 'package:patient_app/core/models/doctor_model.dart';

abstract class FavouriteStates extends Equatable {
  @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteStates {}

class FavouriteLoading extends FavouriteStates {}

class FavouriteFailure extends FavouriteStates {
  final String failureMsg;

  FavouriteFailure({required this.failureMsg});
}

class FavouriteSuccess extends FavouriteStates {
  final List<DoctorModel> doctors;

  FavouriteSuccess({required this.doctors});
}
