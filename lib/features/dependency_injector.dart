import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:trishaheed/features/auth/repository/login_repo.dart';
import 'package:trishaheed/features/auth/service/login_service.dart';
import '../dashboard_cubit.dart';
import 'auth/repository/school_registration_repo.dart';
import 'auth/service/school_registration_service.dart';
import 'auth/viewmodel/auth/login/login_cubit.dart';
import 'auth/viewmodel/auth/register/school_registration_cubit.dart';
import 'auth/viewmodel/onboarding/onboarding_cubit.dart';

class DependencyInjector {
  static List<SingleChildWidget> providers() {
    final SchoolRegistrationRepo loadingRepo = SchoolRegistrationRepo.initial();
    final LoginRepo loginRepo = LoginRepo.initial();

    return [
      FutureProvider<SchoolRegistrationRepo>(
        create: (_) => SchoolRegistrationRepo.create(),
        initialData: SchoolRegistrationRepo.initial(),
      ),
      ProxyProvider<SchoolRegistrationRepo, SchoolRegistrationService>(
          update: (context, repo, service) {
        return repo != loadingRepo
            ? SchoolRegistrationService(repo)
            : SchoolRegistrationServiceInitial(repo);
      }),
      FutureProvider<LoginRepo>(
        create: (_) => LoginRepo.create(),
        initialData: LoginRepo.initial(),
      ),
      ProxyProvider<LoginRepo, LoginService>(update: (_, repo, __) {
        return repo != loginRepo
            ? LoginService(repo)
            : LoginServiceInitial(repo);
      }),
      BlocProvider<OnboardingCubit>(create: (context) {
        final service = context.read<SchoolRegistrationService?>();
        final loginService = context.read<LoginService?>();

        if ((service == null && service is SchoolRegistrationServiceInitial) &&
            loginService == null &&
            loginService is LoginServiceInitial) {
          throw Exception("SchoolRegistrationService is not initialized");
        } else {
          return OnboardingCubit(service!, loginService!);
        }
      }),
      BlocProvider<SchoolRegistrationCubit>(create: (context) {
        final service = context.read<SchoolRegistrationService?>();
        if (service == null || service is SchoolRegistrationServiceInitial) {
          throw Exception("SchoolRegistrationService is not initialized");
        } else {
          return SchoolRegistrationCubit(service);
        }
      }),
      BlocProvider<LoginCubit>(create: (context) {
        final service = context.read<LoginService?>();
        if (service == null || service is LoginServiceInitial) {
          throw Exception("Login Service is not initialized");
        } else {
          return LoginCubit(service);
        }
      }),
      BlocProvider<DashboardCubit>(create: (context) {
        final service = context.read<SchoolRegistrationService?>();
        final loginService = context.read<LoginService?>();
        if ((service == null && service is SchoolRegistrationServiceInitial) &&
            loginService == null &&
            loginService is LoginServiceInitial) {
          throw Exception(
              "SchoolRegistrationService & LoginService are not initialized");
        } else {
          return DashboardCubit(service!, loginService!);
        }
      })
    ];
  }
}
