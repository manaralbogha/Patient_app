import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/models/patient_model.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import 'package:patient_app/core/utils/app_assets.dart';
import 'package:patient_app/core/widgets/custome_error_widget.dart';
import 'package:patient_app/core/widgets/custome_image.dart';
import 'package:patient_app/core/widgets/custome_progress_indicator.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/cubits/my_appointments_cubit/my_appointments_cubit.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/widgets/custom_doctor_item.dart';
import 'package:patient_app/screens/secretary_screens/appointments_requests_screen/widgets/appointment_request_item.dart';
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
          create: (context) => MyAppointmentsCubit()..getMyAppointments(),
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
            drawer: Drawer(
              width: 250.w,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 180.h,
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CustomeImage(
                            height: 75.h,
                            width: 80.w,
                            borderRadius: BorderRadius.circular(50.r),
                            iconSize: 60.sp,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Center(
                          child: Text(
                            homeCubit.patientModel?.userModel?.firstName ?? '',
                            style: TextStyle(
                                fontSize: 25.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: () {
                      _scaffoldKey.currentState!.closeDrawer();
                      homeCubit.logout(context);
                    },
                    icon: Icon(
                      Icons.logout,
                      size: 25.w,
                      color: Colors.red,
                    ),
                    label: Text(
                      'Log Out',
                      style: TextStyle(fontSize: 20.w, color: Colors.black54),
                    ),
                  ),
                ],
              ),
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
                    if (value == 1) {
                      homeCubit.getDoctors();
                    } else {
                      appointmentsCubit.getMyAppointments();
                    }
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
                : AppointmentsViewBody(patientModel: homeCubit.patientModel),
          );
        },
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
        } else if (state is GetDoctorsSuccess) {
          return CustomScrollView(

            physics: const BouncingScrollPhysics(),

            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 150.h,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 130.w,
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(10.r),
                              splashColor: defaultColor,
                              child: Card(
                                // margin: EdgeInsets.all(2),

                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.green, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.r)),
                                ),
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    CustomeImage(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.r),
                                          topRight: Radius.circular(10.r)),
                                      image: AppAssets.stethoscope,
                                      width: double.infinity,
                                      height: 90.h,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    const Text(
                                      "Public Department",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisExtent: 260.h,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 5.w,
                  mainAxisSpacing: 5.h,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return CustomDoctorItem(
                      doctorModel: state.doctors[index],
                    );
                  },
                  childCount: state.doctors.length,
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text('Initial'));
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
          return ListView.builder(
            itemBuilder: (context, index) => const AppointmentRequestItem(),
            itemCount: patientModel != null
                ? state.getMyAppointments(patientID: patientModel!.id!).length
                : state.appointments.length,
          );
        } else {
          return const Center(
            child: Text('Initial'),
          );
        }
      },
    );
  }
}
