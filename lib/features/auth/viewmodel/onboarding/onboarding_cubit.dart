import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trishaheed/features/auth/service/login_service.dart';
import '../../service/school_registration_service.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final SchoolRegistrationService service;
  final LoginService loginService;

  OnboardingCubit(this.service, this.loginService) : super(OnboardingInitial());

  Future<void> verifyUser() async {
    try {
      emit(OnboardingChecking());
      final url = await service.getUrlFromStorage();
      final date = await loginService.getExpiry();
      final token = await loginService.getToken();

      if (url != null) {
        emit(OnboardingComplete(url: url, expiry: date, token: token));
      } else {
        emit(OnboardingError());
      }
    } catch (e) {
      print("Error Setting Up Your School: $e");
      emit(OnboardingError());
    }
  }

  void reset() {
    emit(OnboardingInitial());
  }
}
