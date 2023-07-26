import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/models/appointment_model.dart';
import 'package:patient_app/core/models/patient_model.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import 'package:patient_app/core/widgets/custome_error_widget.dart';
import 'package:patient_app/core/widgets/custome_image.dart';
import 'package:patient_app/core/widgets/custome_progress_indicator.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/cubits/my_appointments_cubit/my_appointments_cubit.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/widgets/custom_doctor_item.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/widgets/custom_drawer_button.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/widgets/my_appointment_item.dart';
import 'package:patient_app/screens/patient_screens/show_all_consultation/show_all_consultation.dart';
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
                  SizedBox(height: 25.h),
                  CustomDrawerButton(
                    text: 'Consultations',
                    icon: Icons.question_answer,
                    onPressed: () {
                      _scaffoldKey.currentState!.closeDrawer();
                      Navigator.pushNamed(
                          context, ShowAllConsultationView.route);
                    },
                  ),
                  SizedBox(height: 15.h),
                  CustomDrawerButton(
                    text: 'Favourite',
                    icon: Icons.favorite_outlined,
                    // iconColor: Colors.red,
                    onPressed: () {
                      _scaffoldKey.currentState!.closeDrawer();
                    },
                  ),
                  const Expanded(child: SizedBox()),
                  CustomDrawerButton(
                    text: 'Log Out',
                    icon: Icons.logout,
                    iconColor: Colors.red,
                    onPressed: () {
                      _scaffoldKey.currentState!.closeDrawer();
                      homeCubit.logout(context);
                    },
                  ),
                  SizedBox(height: 25.h),
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
                    if (value == 0) {
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
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month_sharp),
                    label: 'Appointments',
                  ),
                ],
              ),
            ),
            body: _index == 0
                ? const HomePatientViewBody(
                    // homeCubit: homeCubit,
                    // departments: state.,
                    )
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
                    _departmentsListView(state, homeCubit),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
              homeCubit.departmentID != null
                  ? _doctorSliverGrid(state, homeCubit)
                  : const SliverFillRemaining(
                      child: Center(child: Text('Please Select Department'))),
            ],
          );
        } else {
          return const CustomeProgressIndicator();
        }
      },
    );
  }

  SliverGrid _doctorSliverGrid(
    GetDoctorsAndDepartmentsSuccess state,
    HomePatientCubit homeCubit,
  ) {
    return SliverGrid(
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
            doctorModel: state.getDepartmentDoctors(
                departmentID: homeCubit.departmentID)[index],
          );
        },
        childCount: state
            .getDepartmentDoctors(departmentID: homeCubit.departmentID)
            .length,
      ),
    );
  }

  Container _departmentsListView(
      GetDoctorsAndDepartmentsSuccess state, HomePatientCubit homeCubit) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 150.h,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: state.departments.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 130.w,
            child: InkWell(
              onTap: () {
                if (homeCubit.departmentID != state.departments[index].id) {
                  homeCubit.viewDoctorsForDebarment(
                    departmentsId: state.departments[index].id,
                  );
                }
              },
              borderRadius: BorderRadius.circular(10.r),
              splashColor: defaultColor,
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.passthrough,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: homeCubit.departmentID ==
                                state.departments[index].id
                            ? Colors.green
                            : Colors.grey,
                        width: homeCubit.departmentID ==
                                state.departments[index].id
                            ? 2
                            : 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    ),
                    color: Colors.white,
                    child: Column(
                      children: [
                        CustomeImage(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              topRight: Radius.circular(10.r)),
                          // image: state.departments[index].img,
                          width: double.infinity,
                          height: 90.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          state.departments[index].name.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (homeCubit.departmentID != null &&
                      homeCubit.departmentID == state.departments[index].id)
                    const Positioned(
                      top: -5,
                      right: -5,
                      child: Icon(
                        Icons.check_circle_outline_rounded,
                        color: Colors.green,
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
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
            itemBuilder: (context, index) {
              List<AppointmentModel> myAppointments =
                  state.getMyAppointments(patientID: patientModel!.id!);
              return MyAppointmentItem(
                appointmentID: myAppointments[index].id,
                time:
                    '${myAppointments[index].date} - ${myAppointments[index].time}',
                doctor: 'Abdullah Nahlawi',
                status: '${myAppointments[index].status}...',
              );
            },
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
