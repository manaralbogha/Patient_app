import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_app/core/widgets/custome_error_widget.dart';
import 'package:patient_app/core/widgets/custome_progress_indicator.dart';
import 'package:patient_app/screens/secretary_screens/appointments_requests_screen/widgets/appointment_request_item.dart';
import 'cubit/appointments_requests_cubit.dart';
import 'cubit/appointments_requests_states.dart';

class AppointmentsRequestsView extends StatelessWidget {
  static const route = 'AppointmentsRequestsView';
  final String token;
  const AppointmentsRequestsView({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AppointmentsRequestsCubit()..getAppointmentsRequests(token: token),
      child: const Scaffold(
        body: AppointmentsRequestsViewBody(),
      ),
    );
  }
}

class AppointmentsRequestsViewBody extends StatelessWidget {
  const AppointmentsRequestsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentsRequestsCubit, AppointmentsRequestsStates>(
      builder: (context, state) {
        if (state is AppointmentsRequestsFailure) {
          return CustomeErrorWidget(errorMsg: state.failureMsg);
        } else if (state is AppointmentsRequestsSuccess) {
          return ListView.builder(
            itemBuilder: (context, index) => const AppointmentRequestItem(),
            itemCount: state.appointments.length,
          );
        } else {
          return const CustomeProgressIndicator();
        }
      },
    );
  }
}
