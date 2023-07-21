import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/functions/custome_dialogs.dart';
import 'package:patient_app/screens/login_screen/login_screen.dart';
import 'package:patient_app/screens/register_screen/widgets/choice_button.dart';
import '../../core/styles/app_colors.dart';
import '../../core/styles/text_styles.dart';
import '../../core/widgets/custome_button.dart';
import '../../core/widgets/custome_error_widget.dart';
import '../../core/widgets/custome_progress_indicator.dart';
import '../../core/widgets/custome_text_field.dart';
import '../../main.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_states.dart';

class RegisterView extends StatelessWidget {
  static const route = 'RegisterDoctorView';
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => RegisterCubit(),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: const Scaffold(
            body: RegisterViewBody(),
          ),
        ),
      ),
    );
  }
}

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterCubit cubit = BlocProvider.of(context);
    return BlocBuilder<RegisterCubit, RegisterStates>(
      builder: (context, state) {
        if (state is RegisterLoading) {
          return const CustomeProgressIndicator();
        } else if (state is RegisterFailure) {
          return CustomeErrorWidget(errorMsg: state.failureMsg);
        } else if (state is RegisterSuccess) {
          return const LoginView();
        } else {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: screenSize.width,
                      height: 10,
                    ),
                    SizedBox(height: screenSize.height * .02),
                    Text(
                      'Create Doctor Account',
                      style: TextStyles.textStyle30.copyWith(
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                        fontSize: 27.sp,
                      ),
                    ),
                    SizedBox(height: screenSize.height * .05),
                    CustomeTextField(
                      initialValue: cubit.registerModel.firstName ?? '',
                      hintText: 'First Name ...',
                      iconData: Icons.person,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (value) =>
                          cubit.registerModel.firstName = value,
                    ),
                    SizedBox(height: screenSize.height * .02),
                    CustomeTextField(
                      hintText: 'Last Name ...',
                      iconData: Icons.person,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (value) =>
                          cubit.registerModel.lastName = value,
                    ),
                    SizedBox(height: screenSize.height * .02),
                    CustomeTextField(
                      hintText: 'Email ...',
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => cubit.registerModel.email = value,
                    ),
                    SizedBox(height: screenSize.height * .02),
                    CustomeTextField(
                      hintText: 'Password ...',
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'required';
                        } else {
                          if (value!.length < 6) {
                            return 'password must be at least 6 characters';
                          }
                        }
                        return null;
                      },
                      iconData: Icons.lock,
                      onChanged: (value) =>
                          cubit.registerModel.password = value,
                      obscureText: cubit.obscureText,
                      suffixIcon: IconButton(
                        onPressed: () {
                          cubit.changePasswordState();
                        },
                        icon: Icon(
                          cubit.icon,
                          color: defaultColor,
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * .02),
                    CustomeTextField(
                      obscureText: cubit.obscureText,
                      hintText: 'Confirm Password ...',
                      iconData: Icons.lock,
                      validator: (value) {
                        if (cubit.registerModel.password == null) {
                          return 'required';
                        } else {
                          if (value != cubit.registerModel.password) {
                            return "Passwords doesn't Match";
                          }
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenSize.height * .02),
                    CustomeTextField(
                      keyboardType: TextInputType.phone,
                      hintText: 'Phone ...',
                      iconData: Icons.phone,
                      onChanged: (value) =>
                          cubit.registerModel.phoneNum = value,
                    ),
                    SizedBox(height: screenSize.height * .02),
                    CustomeTextField(
                      hintText: 'Address ...',
                      iconData: Icons.location_on,
                      onChanged: (value) => cubit.registerModel.address = value,
                    ),
                    SizedBox(height: screenSize.height * .02),
                    CustomeTextField(
                      hintText:
                          cubit.registerModel.birthDate ?? 'Birth Date ...',
                      hintStyle: cubit.registerModel.birthDate != null
                          ? const TextStyle(color: Colors.black)
                          : null,
                      validator: (value) {
                        if (cubit.registerModel.birthDate == null) {
                          return 'required';
                        }
                        return null;
                      },
                      iconData: Icons.date_range_rounded,
                      disableFocusNode: true,
                      onTap: () async {
                        cubit.date =
                            (await CustomDialogs.pickDateDialog(context))
                                .toString();

                        cubit.selectBirthDate();
                      },
                      suffixIcon: const Icon(
                        Icons.expand_more_sharp,
                        size: 40,
                        color: defaultColor,
                      ),
                      onChanged: (value) =>
                          cubit.registerModel.birthDate = value,
                    ),
                    SizedBox(height: screenSize.height * .02),
                    CustomeChoiceButton(
                      femaleColor: cubit.female,
                      maleColor: cubit.male,
                      femaleTextColor: cubit.femaleTextColor,
                      maleTextColor: cubit.maleTextColor,
                      maleOnTap: () => cubit.selectGender(type: 'Male'),
                      femaleOnTap: () => cubit.selectGender(type: 'Female'),
                    ),
                    SizedBox(height: screenSize.height * .05),
                    CustomeButton(
                      text: 'Next',
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.register(context);
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
