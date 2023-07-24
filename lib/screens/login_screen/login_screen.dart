import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/home_patient_screen.dart';
import 'package:patient_app/screens/register_screen/register_screen.dart';
import '../../core/api/services/local/cache_helper.dart';
import '../../core/styles/app_colors.dart';
import '../../core/styles/text_styles.dart';
import '../../core/utils/app_assets.dart';
import '../../core/widgets/custome_button.dart';
import '../../core/widgets/custome_error_widget.dart';
import '../../core/widgets/custome_image.dart';
import '../../core/widgets/custome_progress_indicator.dart';
import '../../core/widgets/custome_text_field.dart';
import '../../main.dart';
import '../secretary_screens/appointments_requests_screen/appointments_requests_view.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

class LoginView extends StatelessWidget {
  static const route = 'LoginView';
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: const Scaffold(
            body: LoginViewBody(),
          ),
        ),
      ),
    );
  }
}

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (context, state) {
        if (state is LoginLoading) {
          return const CustomeProgressIndicator();
        } else if (state is LoginFailure) {
          return CustomeErrorWidget(errorMsg: state.failureMsg);
        } else if (state is LoginSuccess) {
          CacheHelper.saveData(key: 'Token', value: state.loginModel.token);
          CacheHelper.saveData(key: 'Role', value: state.loginModel.role);
          if (state.loginModel.role == 'secretary') {
            return AppointmentsRequestsView(token: state.loginModel.token);
          }
          return const HomePatientView();
        } else {
          return _body(context);
        }
      },
    );
  }

  Widget _body(context) {
    LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);
    return SingleChildScrollView(
      // physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: loginCubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomeImage(
                image: AppAssets.loginImage,
                width: screenSize.width * .8,
                height: screenSize.height * .3,
              ),
              // SizedBox(height: screenSize.height * .02),
              Text(
                'Login',
                style: TextStyles.textStyle50,
              ),
              SizedBox(height: screenSize.height * .015),
              Text(
                'Please Enter Your Credentials To Get Started ...',
                style: TextStyles.textStyle18
                    .copyWith(fontStyle: FontStyle.italic),
                maxLines: 2,
              ),
              SizedBox(height: screenSize.height * .05),
              CustomeTextField(
                keyboardType: TextInputType.emailAddress,
                hintText: ' Email ...',
                onChanged: (value) => loginCubit.email = value,
              ),
              SizedBox(height: screenSize.height * .04),
              CustomeTextField(
                iconData: Icons.lock,
                hintText: ' Password ...',
                obscureText: loginCubit.obscureText,
                onChanged: (value) => loginCubit.password = value,
                suffixIcon: IconButton(
                  onPressed: () {
                    loginCubit.changePasswordState();
                  },
                  icon: Icon(
                    loginCubit.icon,
                    color: defaultColor,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Center(
                child: CustomeButton(
                  text: 'Login',
                  onPressed: () {
                    if (loginCubit.formKey.currentState!.validate()) {
                      loginCubit.login();
                    }
                  },
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't Hava an Account?",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterView.route);
                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }
}
