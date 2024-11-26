import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trishaheed/features/auth/views/screen/splash_screen.dart';
import 'package:trishaheed/features/dependency_injector.dart';
import 'package:trishaheed/features/routes.dart';
import '../../service/school_registration_service.dart';
import '../../views/screen/school_registration_screen.dart';
import '../auth/login/login_cubit.dart';
import '../auth/register/school_registration_cubit.dart';
import '../onboarding/onboarding_cubit.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  void reset(BuildContext context) {
    // final loginCubit = context.read<LoginCubit>();
    // final registrationCubit = context.read<SchoolRegistrationCubit>();
    // final onBoardingCubit = context.read<OnboardingCubit>();
    // loginCubit.close();
    // registrationCubit.close();
    // onBoardingCubit.close();
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.splashScreen, (Route<dynamic> route) => false);
    // DependencyInjector.providers();
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
