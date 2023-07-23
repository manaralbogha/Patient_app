import 'package:flutter/material.dart';
import '../../screens/login_screen/login_screen.dart';
import '../../screens/patient_screens/add_appointment_view/add_appointment_view.dart';
import '../../screens/patient_screens/doctor_details_screen/doctor_details_screen.dart';
import '../../screens/patient_screens/home_patient_screen/home_patient_screen.dart';
import '../../screens/patient_screens/show_all_consultation/show_all_consultation.dart';
import '../../screens/register_screen/register_screen.dart';
import '../../screens/secretary_screens/appointments_requests_screen/appointments_requests_view.dart';
import '../api/services/local/cache_helper.dart';

abstract class AppRouter {
  static final router = <String, WidgetBuilder>{
    LoginView.route: (context) => const LoginView(),
    RegisterView.route: (context) => const RegisterView(),
    AddAppointmentView.route: (context) => const AddAppointmentView(),
    HomePatientView.route: (context) => const HomePatientView(),
    DoctorDetailsView.route: (context) => const DoctorDetailsView(),
    AppointmentsRequestsView.route: (context) =>
        AppointmentsRequestsView(token: CacheHelper.getData(key: 'Token')),
    ShowAllConsultationView.route: (context) => const ShowAllConsultationView(),
  };
}
