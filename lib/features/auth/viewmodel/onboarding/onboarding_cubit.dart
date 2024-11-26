import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../service/school_registration_service.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final SchoolRegistrationService service;

  OnboardingCubit(this.service) : super(OnboardingInitial());

  Future<void> findSchoolUrl() async {
    try {
      emit(OnboardingChecking());
      final url = await service.getUrlFromStorage();

      if (url != null) {
        emit(OnboardingComplete(url: url));
      } else {
        emit(OnboardingError());
      }
    } catch (e) {
      print(e);
      emit(OnboardingError());
    }
  }

  void reset() {
    emit(OnboardingInitial());
  }
}
