import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_app/core/widgets/custome_error_widget.dart';
import 'package:patient_app/core/widgets/custome_progress_indicator.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/cubit/home_patient_cuibt.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/cubit/home_patient_states.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/widgets/custom_doctor_item.dart';
import 'package:patient_app/screens/secretary_screens/appointments_requests_screen/widgets/appointment_request_item.dart';

class HomePatientView extends StatefulWidget {
  static const route = 'HomePatientView';
  const HomePatientView({super.key});

  @override
  State<HomePatientView> createState() => _HomePatientViewState();
}

class _HomePatientViewState extends State<HomePatientView> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePatientCubit()..getDoctors(token: ''),
      child: Scaffold(
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            fixedColor: Colors.purple.shade300,
            onTap: (value) {
              setState(() {
                _index = value;
              });
            },
            currentIndex: _index,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_sharp),
                label: 'Appointments',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
        body: _index == 1
            ? const HomePatientViewBody()
            : const AppointmentsViewBody(),
      ),
    );
  }
}

class HomePatientViewBody extends StatelessWidget {
  const HomePatientViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePatientCubit, HomePatientStates>(
      builder: (context, state) {
        if (state is HomePatientLoading) {
          return const CustomeProgressIndicator();
        } else if (state is HomePatientFailure) {
          return CustomeErrorWidget(errorMsg: state.failureMsg);
        } else if (state is HomePatientSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => CustomDoctorItem(
                    doctorModel: state.doctors[index],
                  ),
                  itemCount: state.doctors.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              // const Expanded(child: SizedBox()),
            ],
          );
        } else {
          return const Text('Initial');
        }
      },
    );
  }
}

class AppointmentsViewBody extends StatelessWidget {
  const AppointmentsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AppointmentRequestItem(),
    );
  }
}
