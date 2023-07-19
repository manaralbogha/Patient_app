
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'package:patient_app/screens/add_appointment_view/add_appointment_view.dart';
import 'package:patient_app/screens/login_screen/login_screen.dart';

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
              : AddAppointmentView.route,
          routes: {
            LoginView.route: (context) => const LoginView(),
            AddAppointmentView.route: (context) => const AddAppointmentView(),
          },
        );

            
            
            

      },
    );
  }
}
