import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:patient_app/core/api/services/appointment/add_appointment_service.dart';
import 'package:patient_app/core/api/services/appointment/get_all_doctors_times_service.dart';
import 'package:patient_app/core/api/services/get_department_details_service.dart';
import 'package:patient_app/core/models/doctor_model.dart';
import 'package:patient_app/core/models/work_day_model.dart';
import '../../../../core/models/add_appointment_model.dart';
import '../../../../core/utils/constants.dart';
import 'add_appointment_states.dart';

class AddAppointmentCubit extends Cubit<AddAppointmentStates> {
  AddAppointmentCubit() : super(AddAppointmentInitial());
  List<String> dates = [];
  List<String> days = [];
  int? selectIndexDay;
  int? selectIndexTime;
  AddAppointmentModel addAppointmentModel = AddAppointmentModel();
  final discretionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<WorkDayModel> doctorTimes = [];

  // Duration? diff;

  Future<void> fetchDoctorTimes({required DoctorModel doctorModel}) async {
    emit(AddAppointmentLodgingState());
    (await GetAllDoctorsTimes.getAllDoctorsTimes(token: Constants.adminToken))
        .fold(
      (failure) {
        emit(AddAppointmentFailureState(failureMsg: failure.errorMessege));
      },
      (allDoctorsTimes) async {
        for (WorkDayModel item in allDoctorsTimes) {
          if (doctorModel.id == item.doctorID) {
            doctorTimes.add(item);
          }
        }
        if (doctorModel.departmentImage == null) {
          (await GetDepartmentDetailsService.getDepartmentDetails(
                  id: doctorModel.departmentID))
              .fold(
            (failure) {},
            (department) {
              doctorModel.departmentImage = department.img;
            },
          );
        }
        emit(AddAppointmentInitial());
      },
    );
  }

  int getDifference({required WorkDayModel time}) {
    DateTime t1 = getDateTime(time: time.startTime);
    DateTime t2 = getDateTime(time: time.endTime);
    return t1.difference(t2).inHours.abs();
  }

  DateTime getDateTime({required String time}) {
    String s = time.substring(time.length - 2, time.length);
    String s2 = time.substring(0, 2);
    if (s2 == '12') {
      if (s == 'AM') {
        return DateTime(2023, 1, 1, 0);
      } else {
        return DateTime(2023, 1, 1, 12);
      }
    } else {
      int hour = (s == 'AM') ? int.parse(s2) : int.parse(s2) + 12;
      return DateTime(2023, 1, 1, hour);
    }
  }

  String dateTimeToString({required DateTime time}) {
    String hour = (time.hour > 12)
        ? (time.hour - 12 < 10)
            ? '0${time.hour - 12}'
            : '${time.hour - 12}'
        : (time.hour < 10)
            ? '0${time.hour}'
            : '${time.hour}';

    String minute = (time.minute == 0) ? '00' : '${time.minute}';

    String aMpM = (time.hour > 11 && time.hour != 0) ? 'PM' : 'AM';

    return '$hour:$minute $aMpM';
  }

  List<String> getTimesBetween({required WorkDayModel time}) {
    int diff = (getDifference(time: time) * 2);
    List<DateTime> times = [];
    List<String> list = [];
    times.add(getDateTime(time: time.startTime));
    list.add(time.startTime);
    for (int i = 1; i < diff; i++) {
      times.add(times[i - 1].add(const Duration(minutes: 30)));
      list.add(dateTimeToString(time: times[i]));
    }
    list.add(time.endTime);
    return list;
  }

  void storeDoctorTimes({required WorkDayModel time}) {
    times1.clear();
    times2.clear();
    List<String> times = getTimesBetween(time: time);

    if (times.length.isOdd) {
      int x = times.length + 1;

      int x1 = x ~/ 2;

      for (int i = 0; i < x1; i++) {
        times1.add(times[i]);
      }
      for (int i = x1; i < times.length; i++) {
        times2.add(times[i]);
      }
    } else {
      for (int i = 0; i < times.length / 2; i++) {
        times1.add(times[i]);
      }
      for (int i = times.length / 2 as int; i < times.length; i++) {
        times2.add(times[i]);
      }
    }
  }

  List<String> times1 = [];
  List<String> times2 = [];

  List<String> createDatesList() {
    dates.clear();
    days.clear();
    var jiffy = Jiffy.now();

    for (int i = 0; i < 32; i++) {
      jiffy = jiffy.add(days: 1);
      dates.add(jiffy.format(pattern: 'MMM  dd'));
      days.add(jiffy.EEEE);
    }
    return dates;
  }

  void selectDay({required int index, required String day}) {
    emit(AddAppointmentInitial());
    times1.clear();
    times2.clear();
    selectIndexDay = index;
    addAppointmentModel.date = '${days[index]} ${dates[index]}';
    for (var element in doctorTimes) {
      if (element.day == day) {
        storeDoctorTimes(time: element);
      }
    }
    log('${addAppointmentModel.date}');
    emit(SelectDayState());
  }

  void selectTime({required int index, required int indexR}) {
    emit(AddAppointmentInitial());
    selectIndexTime = index;
    addAppointmentModel.time = indexR == 0 ? times1[index] : times2[index];
    log('${addAppointmentModel.time}');
    emit(SelectTimeState());
  }

  Future<void> addAppointment(
      {required int doctorID,
      required int departmentID,
      required String token}) async {
    addAppointmentModel.description = discretionController.text;
    addAppointmentModel.doctorIid = '$doctorID';
    addAppointmentModel.departmentId = '$departmentID';
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

  bool vaildWorkDay({required String day}) {
    for (WorkDayModel item in doctorTimes) {
      if (item.day == day) {
        return true;
      }
    }
    return false;
  }
}
