import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import 'package:patient_app/screens/login_screen/login_screen.dart';
import 'package:patient_app/screens/patient_screens/add_appointment_view/add_appointment_view.dart';
import 'package:patient_app/screens/patient_screens/doctor_details_screen/doctor_details_screen.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/home_patient_screen.dart';
import 'package:patient_app/screens/patient_screens/show_all_consultation/show_all_consultation.dart';
import 'package:patient_app/screens/register_screen/register_screen.dart';
import 'package:patient_app/screens/secretary_screens/appointments_requests_screen/appointments_requests_view.dart';

void main() async {
  String initalRoute;
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  if (await CacheHelper.getData(key: 'Token') == null) {
    initalRoute = LoginView.route;
  } else if (await CacheHelper.getData(key: 'Role') == 'secretary') {
    initalRoute = AppointmentsRequestsView.route;
  } else {
    initalRoute = DoctorDetailsView.route;
  }
  runApp(PatientApp(
    initialRoute: initalRoute,
  ));
}

late Size screenSize;

class PatientApp extends StatelessWidget {
  final String initialRoute;
  const PatientApp({super.key, required this.initialRoute});

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
          home: CacheHelper.getData(key: 'Token') == null
              ? const LoginView()
              : CacheHelper.getData(key: 'Role') == 'secretary'
                  ? AppointmentsRequestsView(
                      token: CacheHelper.getData(key: 'Token'))
                  : const DoctorDetailsView(),
          initialRoute: initialRoute,
          routes: {
            LoginView.route: (context) => const LoginView(),
            RegisterView.route: (context) => const RegisterView(),
            AddAppointmentView.route: (context) => const AddAppointmentView(),
            HomePatientView.route: (context) => const HomePatientView(),
            AppointmentsRequestsView.route: (context) =>
                AppointmentsRequestsView(
                    token: CacheHelper.getData(key: 'Token')),
            ShowAllConsultationView.route: (context) =>
                const ShowAllConsultationView(),
          },
        );
      },
    );
  }
}
