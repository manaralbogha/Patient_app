import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'package:patient_app/screens/add_appointment_view/add_appointment_view.dart';
import 'package:patient_app/screens/appointments_requests_screen/appointments_requests_view.dart';
import 'package:patient_app/screens/login_screen/login_screen.dart';
import 'package:patient_app/screens/register_screen/register_screen.dart';

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
          ),
          initialRoute: CacheHelper.getData(key: 'Token') == null
              ? LoginView.route
              : CacheHelper.getData(key: 'Role') == 'secretary'
                  ? AppointmentsRequestsView.route
                  : AddAppointmentView.route,
          routes: {
            LoginView.route: (context) => const LoginView(),
            RegisterView.route: (context) => const RegisterView(),
            AddAppointmentView.route: (context) => const AddAppointmentView(),
            AppointmentsRequestsView.route: (context) =>
                AppointmentsRequestsView(
                    token: CacheHelper.getData(key: 'Token')),
          },
        );
      },
    );
  }
}
