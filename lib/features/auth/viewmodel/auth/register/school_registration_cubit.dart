import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trishaheed/features/auth/model/AuthFailure.dart';
import 'package:trishaheed/features/auth/service/school_registration_service.dart';
import 'package:trishaheed/features/auth/service/validation_service.dart';

part 'school_registration_state.dart';

class SchoolRegistrationCubit extends Cubit<SchoolRegistrationState> {
  final SchoolRegistrationService service;

  SchoolRegistrationCubit(this.service) : super(SchoolRegistrationInitial());

  Future<void> submitRegistrationForm(String name, String code) async {
    print("name $name and password $code");
    emit(SchoolRegistrationLoading());
    try {
      final url = await service.getUrlFromInternetAndSave(name, code);
      print("Url: ${service.getUrlFromStorage()}");
      if (url != null) {
        emit(SchoolRegistrationComplete());
      } else {
        emit(SchoolRegistrationFailure());
      }
    } catch (e) {
      emit(SchoolRegistrationFailure());
    }
  }

  String? validateCode(String? code) =>
      ValidationService.validateCode(code ?? '');

  String? validateName(String? name) =>
      ValidationService.validateName(name ?? '');

  @override
  Future<void> close() {
    return super.close();
  }
}
