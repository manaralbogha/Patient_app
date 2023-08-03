import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/models/patient_model.dart';
import 'package:patient_app/core/widgets/custome_error_widget.dart';
import 'package:patient_app/core/widgets/custome_progress_indicator.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/cubits/my_appointments_cubit/my_appointments_cubit.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/widgets/custom_drawer.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/widgets/departments_list_view.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/widgets/doctors_grid_view.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/widgets/my_appointment_item.dart';
import 'cubits/home_cubit/home_patient_cuibt.dart';
import 'cubits/home_cubit/home_patient_states.dart';

class HomePatientView extends StatefulWidget {
  static const route = 'HomePatientView';

  const HomePatientView({super.key});

  @override
  State<HomePatientView> createState() => _HomePatientViewState();
}

class _HomePatientViewState extends State<HomePatientView> {
  int _index = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomePatientCubit()..fetchMyInfo(),
        ),
        BlocProvider(
          create: (context) => MyAppointmentsCubit(),
        ),
      ],
      child: BlocBuilder<HomePatientCubit, HomePatientStates>(
        builder: (context, state) {
          HomePatientCubit homeCubit =
              BlocProvider.of<HomePatientCubit>(context);
          MyAppointmentsCubit appointmentsCubit =
              BlocProvider.of<MyAppointmentsCubit>(context);
          return Scaffold(
            key: _scaffoldKey,
            drawer: CustomDrawer.getCustomDrawer(
              context,
              homeCubit: homeCubit,
              scaffoldKey: _scaffoldKey,
            ),
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20.r),
                ),
              ),
              title: Text(
                'Welcom ${homeCubit.patientModel?.userModel?.firstName ?? ''}',
                style: TextStyle(fontSize: 20.w),
              ),
              actions: const [
                Icon(Icons.notifications),
                SizedBox(width: 5),
              ],
            ),
            bottomNavigationBar: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                fixedColor: Colors.purple.shade300,
                onTap: (value) {
                  setState(() {
                    if (value == 0) {
                      homeCubit.getDoctorsAndDepartments();
                    } else {
                      appointmentsCubit.getMyAppointments(
                          patientID: homeCubit.patientModel!.id!);
                    }
                    _index = value;
                  });
                },
                currentIndex: _index,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month_sharp),
                    label: 'Appointments',
                  ),
                ],
              ),
            ),
            body: _index == 0
                ? const HomePatientViewBody()
                : AppointmentsViewBody(patientModel: homeCubit.patientModel),
          );
        },
      ),
    );
  }
}

class HomePatientViewBody extends StatelessWidget {
  const HomePatientViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePatientCubit, HomePatientStates>(
      builder: (context, state) {
        HomePatientCubit homeCubit = BlocProvider.of<HomePatientCubit>(context);
        if (state is HomePatientLoading) {
          return const CustomeProgressIndicator();
        } else if (state is HomePatientFailure) {
          return CustomeErrorWidget(errorMsg: state.failureMsg);
        } else if (state is GetDoctorsAndDepartmentsSuccess) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DepartmentsListView(homeCubit: homeCubit, state: state),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
              homeCubit.departmentID != null
                  ? DoctorsSliverGrid(homeCubit: homeCubit, state: state)
                  : const SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'Please Select Department',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
            ],
          );
        } else {
          return const CustomeProgressIndicator();
        }
      },
    );
  }
}

class AppointmentsViewBody extends StatelessWidget {
  final PatientModel? patientModel;
  const AppointmentsViewBody({super.key, this.patientModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAppointmentsCubit, MyAppointmentsStates>(
      builder: (context, state) {
        if (state is MyAppointmentsLoading) {
          return const CustomeProgressIndicator();
        } else if (state is MyAppointmentsFailure) {
          return CustomeErrorWidget(errorMsg: state.failureMsg);
        } else if (state is MyAppointmentsSuccess) {
          if (state.appointments.isNotEmpty) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return MyAppointmentItem(
                  appointmentModel: state.appointments[index],
                );
              },
              itemCount: state.appointments.length,
            );
          } else {
            return Center(
              child: Text(
                'No Appointments Sent',
                style: TextStyle(fontSize: 22.w, color: Colors.black54),
              ),
            );
          }
        } else {
          return const Center(
            child: Text('Initial'),
          );
        }
      },
    );
  }
}
