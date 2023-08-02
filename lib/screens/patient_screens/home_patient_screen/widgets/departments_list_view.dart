import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custome_image.dart';
import '../cubits/home_cubit/home_patient_cuibt.dart';
import '../cubits/home_cubit/home_patient_states.dart';

class DepartmentsListView extends StatelessWidget {
  final GetDoctorsAndDepartmentsSuccess state;
  final HomePatientCubit homeCubit;
  const DepartmentsListView({
    super.key,
    required this.state,
    required this.homeCubit,
  });

  @override
  Widget build(BuildContext context) {
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
                  homeCubit.departmentIndex = index;
                  homeCubit.viewDoctorsForDebarment(
                    departmentsId: state.departments[index].id,
                    departmentImage: state.departments[index].img,
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
                        CustomeNetworkImage(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              topRight: Radius.circular(10.r)),
                          // image: state.departments[index].img,
                          width: double.infinity,
                          height: 90.h,
                          imageUrl: state.departments[index].img,
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
