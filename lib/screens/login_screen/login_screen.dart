import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jiffy/jiffy.dart';

import 'package:patient_app/screens/add_appointment_view/add_appointment_view.dart';

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
          return const AddAppointmentView();
        } else {
          return _body(context);
        }
      },
    );
  }

  Widget _body(context) {
    LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomeImage(
              image: AppAssets.loginImage,
              width: screenSize.width * .8,
              height: screenSize.height * .3,
            ),
            SizedBox(height: screenSize.height * .02),
            Text(
              'Login',
              style: TextStyles.textStyle50,
            ),
            SizedBox(height: screenSize.height * .02),
            Text(
              'Please Enter Your Credentials To Get Started ...',
              style: TextStyles.textStyle18,
              maxLines: 2,
            ),
            SizedBox(height: screenSize.height * .06),
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
            SizedBox(height: screenSize.height * .15),
            Center(
              child: CustomeButton(
                text: 'Login',
                onPressed: () {
                  loginCubit.login();
                },
              ),
            ),
            SizedBox(height: screenSize.height * .04),
          ],
        ),
      ),
    );
  }
}


class AddAppointmentView extends StatelessWidget {
  static const route = 'AddAppointmentView';
  const AddAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TestDates(dates: _createDatesList()),
              ),
            );
          },
          child: const Text('Add Appointment'),
        ),
      ),
    );
  }

  List<String> _createDatesList() {
    var jiffy = Jiffy.now();
    List<String> dates = [];
    dates.add(jiffy.MMMMEEEEd);
    for (int i = 0; i < 30; i++) {
      jiffy = jiffy.add(days: 1);
      dates.add(jiffy.MMMMEEEEd);
    }

    log('List = $dates');
    return dates;
  }
}

class TestDates extends StatelessWidget {
  final List<String> dates;
  const TestDates({super.key, required this.dates});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Text(
              dates[index],
              style: const TextStyle(color: Colors.black, fontSize: 20),
            );
          },
          itemCount: dates.length,
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}


