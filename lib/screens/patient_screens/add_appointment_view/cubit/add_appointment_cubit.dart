import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:patient_app/core/api/services/appointment/add_appointment_service.dart';
import 'package:patient_app/screens/add_appointment_view/cubit/add_appointment_states.dart';

import '../../../core/models/add_appointment_model.dart';

class AddAppointmentCubit extends Cubit<AddAppointmentStates> {
  AddAppointmentCubit() : super(AddAppointmentInitial());
  List<String> dates = [];
  List<String> days = [];
  List<String> apiDate = [];
  int? selectIndexDay;
  int? selectIndexTime;
  AddAppointmentModel addAppointmentModel = AddAppointmentModel();
  final discretionController = TextEditingController();

  List<String> times1 = [
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
  ];
  List<String> times2 = [
    '04:00 PM',
    '05:00 PM',
    '06:00 PM',
    '07:00 PM',
    '08:00 PM',
    '09:00 PM',
  ];

  List<String> createDatesList() {
    dates.clear();
    days.clear();
    var jiffy = Jiffy.now();

    dates.add(jiffy.format(pattern: 'MMM  dd'));
    days.add(jiffy.EEEE);

    for (int i = 0; i < 30; i++) {
      jiffy = jiffy.add(days: 1);
      dates.add(jiffy.format(pattern: 'MMM  dd'));
      days.add(jiffy.EEEE);
      // apiDate.add(jiffy.format(pattern: 'yyyy//dd'));
    }

    // log('List = $dates');
    return dates;
  }

  void selectDay({required int index}) {
    emit(AddAppointmentInitial());
    selectIndexDay = index;
    addAppointmentModel.date = '${days[index]} ${dates[index]}';
    print(addAppointmentModel.date);
    emit(SelectDayState());
  }

  void selectTime({required int index, required int indexR}) {
    emit(AddAppointmentInitial());
    selectIndexTime = index;
    addAppointmentModel.time = indexR == 0 ? times1[index] : times2[index];
    print(addAppointmentModel.time);
    emit(SelectTimeState());
  }

  Future<void> addAppointment(
      {required AddAppointmentModel addAppointmentModel,
      required String token}) async {
    emit(AddAppointmentLodgingState());
    (await AddAppointmentService.addAppointment(
            token: token, addAppointmentModel: addAppointmentModel))
        .fold(
      (failure) {
        emit(
          AddAppointmentFailureState(failureMsg: failure.errorMessege),
        );
      },
      (appointmentModel) {
        emit(
          AddAppointmentSuccessState(addAppointmentModel: addAppointmentModel),
        );
      },
    );
  }
}
