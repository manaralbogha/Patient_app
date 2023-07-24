import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import 'package:patient_app/core/utils/app_router.dart';
import 'package:patient_app/screens/login_screen/login_screen.dart';
import 'package:patient_app/screens/patient_screens/doctor_details_screen/doctor_details_screen.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/home_patient_screen.dart';
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
                iconTheme: IconThemeData(color: Colors.white, size: 30.w),
                color: defaultColor,
                centerTitle: true,
                actionsIconTheme: IconThemeData(
                  color: Colors.white,
                  size: 30.w,
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
                    : const HomePatientView(),
            // initialRoute: initialRoute,
            routes: AppRouter.router);
      },
    );
  }
}
