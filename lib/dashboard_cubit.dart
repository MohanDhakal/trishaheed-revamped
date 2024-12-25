import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trishaheed/features/auth/service/login_service.dart';
import 'package:trishaheed/features/auth/service/school_registration_service.dart';
import 'package:trishaheed/features/routes.dart';
part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  SchoolRegistrationService registrationService;
  LoginService loginService;
  DashboardCubit(this.registrationService, this.loginService)
      : super(DashboardInitial(0));

  void reset(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.splashScreen, (Route<dynamic> route) => false);
  }

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> fetchUserInfo() async {
    final verified = await verifyUser();
    if (verified) {}
  }

  Future<bool> verifyUser() async {
    final token = await loginService.getToken();
    final expiryDate = await loginService.getExpiry();
    return (token != null && expiryDate != null);
  }

  onTabSelected(int index) {
    emit(DashboardInitial(index));
  }
}
