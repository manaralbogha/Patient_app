import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:patient_app/core/api/services/appointment/add_appointment_service.dart';
import 'package:patient_app/core/api/services/appointment/get_all_doctors_times_service.dart';
import 'package:patient_app/core/models/work_day_model.dart';
import '../../../../core/models/add_appointment_model.dart';
import 'add_appointment_states.dart';

class AddAppointmentCubit extends Cubit<AddAppointmentStates> {
  AddAppointmentCubit() : super(AddAppointmentInitial());
  List<String> dates = [];
  List<String> days = [];
  List<String> apiDate = [];
  int? selectIndexDay;
  int? selectIndexTime;
  AddAppointmentModel addAppointmentModel = AddAppointmentModel();
  final discretionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final String _adminToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWRjYzJjY2RmMDA3MGNlY2U0NmRkYmRmODUwYjc0YmIwNWE0ZDFmNDhkN2NhY2MyNmRhZDgwNGEzZThkOTcxY2ZmMzJmMDdjYTUxOTVhNzMiLCJpYXQiOjE2OTAwNTE1NjAuODM5NzU2LCJuYmYiOjE2OTAwNTE1NjAuODM5NzYsImV4cCI6MTcyMTY3Mzk2MC43MDMyNDgsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.V01I5ACEWzkp2g58jf4Dca9EX54mPflBQDxM3slYyvhGAKdXj06vaVao83F4xEvc8Up7BDO8cuqjh_zQ4Rw5M9Vlg0KqdEiAYTE7JHu1gnrHj8KceHqQe59mZsLzeB9GjwVs_Q0q-nsaV0qG9deLK7xM-lS2_FKDvXAkwgty97mjuZNWbIhnXvh5hbF_bYpkZsV7eKrd9m1i4pu9xvAoV6p1UxvV9JEtwVw4X89Z9s03tt1W1pHy59xW8XxUF_V9yGljFLjY_d6fgNc8vCG5LwlxA3avVPu4l3zy2LNymi6MQTxrgOB3SmdjqFEBGJFNk5QWi6Q67bVz5dnpeuI7IEMd9O3SBEMIejYchJ3doUd3DkcJbnGdpu_lN4NPdDiPUOptciXm76HHoUujHqfMMh-d9ryyEqxLD9fqJp3bSwT8pPiUUYrrc8ZxD6Ss0mds2v8pTE-XMRddvXanisqXNxE935D9RmuJ8SFffw9Qo3IAiXdoLeTVQARdRvaiR-iuOUfe-XOZ0JQwedjG0sH12dw3Yv4K0uzBeb_3Q3F2_1pu_33YF3C7mOqAQOZ2R89eglXE6d1cGEskFXQhvv-GSVo5M5UHOIokOvk4xezxJCPTkQhlLglu5JRdjywgbOoyHMPWr_Ztg-YHZHWMrNbYgtyn8mO-Zah9_xE1KMu0dr8';

  List<WorkDayModel> doctorTimes = [];

  Duration? diff;

  Future<void> fetchDoctorTimes({required int doctorID}) async {
    emit(AddAppointmentLodgingState());
    (await GetAllDoctorsTimes.getAllDoctorsTimes(token: _adminToken)).fold(
      (failure) {
        emit(AddAppointmentFailureState(failureMsg: failure.errorMessege));
      },
      (allDoctorsTimes) {
        for (WorkDayModel item in allDoctorsTimes) {
          if (doctorID == item.doctorID) {
            doctorTimes.add(item);
          }
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
}
