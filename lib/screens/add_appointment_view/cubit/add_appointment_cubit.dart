import 'dart:developer';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:patient_app/screens/add_appointment_view/cubit/add_appointment_states.dart';

class AddAppointmentCubit extends Cubit<AddAppointmentStates> {
  AddAppointmentCubit() : super(AddAppointmentInitial());
  List<String> dates = [];
  List<String> days = [];
  List<String> apiDate = [];
  int? selectIndexDay;

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
    emit(SelectDayState());
  }
}
