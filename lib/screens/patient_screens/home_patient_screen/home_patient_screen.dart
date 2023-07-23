import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/models/patient_model.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import 'package:patient_app/core/utils/app_assets.dart';
import 'package:patient_app/core/widgets/custome_error_widget.dart';
import 'package:patient_app/core/widgets/custome_image.dart';
import 'package:patient_app/core/widgets/custome_progress_indicator.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/widgets/custom_doctor_item.dart';
import 'package:patient_app/screens/secretary_screens/appointments_requests_screen/widgets/appointment_request_item.dart';

import 'cubits/home_cubit/home_patient_cuibt.dart';
import 'cubits/home_cubit/home_patient_states.dart';

class HomePatientView extends StatefulWidget {
  static const route = 'HomePatientView';
  final PatientModel? patientModel;
  const HomePatientView({super.key, this.patientModel});

  @override
  State<HomePatientView> createState() => _HomePatientViewState();
}

class _HomePatientViewState extends State<HomePatientView> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomePatientCubit()..getDoctors(token: ''),
        ),
      ],
      child: Scaffold(
        drawer: Drawer(
          width: 250.w,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 180.h,
                color: Colors.white,
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
                        widget.patientModel?.userModel?.firstName ?? '',
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.bold),

                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          appBar: AppBar(),
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
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 150.h,
                      child: ListView.builder(
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
                                  side:
                                      BorderSide(color: Colors.green, width: 2),
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
                                      "Manar Albogha",
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

                    // const Expanded(child: SizedBox()),
                  ],
                ),
              ),
              SliverFillRemaining(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisExtent: 260.h,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 5.w,
                      mainAxisSpacing: 5.h),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => CustomDoctorItem(
                    doctorModel: state.doctors[index],
                  ),
                  itemCount: state.doctors.length,
                  // scrollDirection: Axis.horizontal,
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
  const AppointmentsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AppointmentRequestItem(),
    );
  }
}
