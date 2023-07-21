import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import 'package:patient_app/screens/login_screen/login_screen.dart';
import 'package:patient_app/screens/patient_screens/add_appointment_view/add_appointment_view.dart';
import 'package:patient_app/screens/patient_screens/doctor_details_screen/doctor_details_screen.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/home_patient_screen.dart';
import 'package:patient_app/screens/register_screen/register_screen.dart';
import 'package:patient_app/screens/secretary_screens/appointments_requests_screen/appointments_requests_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const PatientApp());
}

late Size screenSize;

class PatientApp extends StatelessWidget {
  const PatientApp({super.key});

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              color: defaultColor,
              centerTitle: true,
              actionsIconTheme: IconThemeData(
                color: Colors.white,
                size: 23.sp,
              ),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 23.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          initialRoute: CacheHelper.getData(key: 'Token') == null
              ? LoginView.route
              : CacheHelper.getData(key: 'Role') == 'secretary'
                  ? AppointmentsRequestsView.route
                  : DoctorDetailsView.route,
          routes: {
            LoginView.route: (context) => const LoginView(),
            RegisterView.route: (context) => const RegisterView(),
            AddAppointmentView.route: (context) => const AddAppointmentView(),
            HomePatientView.route: (context) => const HomePatientView(),
            AppointmentsRequestsView.route: (context) =>
                AppointmentsRequestsView(
                    token: CacheHelper.getData(key: 'Token')),
          },
        );
      },
    );
  }
}
