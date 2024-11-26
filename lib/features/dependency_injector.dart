import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'auth/repository/school_registration_repo.dart';
import 'auth/service/school_registration_service.dart';
import 'auth/viewmodel/auth/login/login_cubit.dart';
import 'auth/viewmodel/auth/register/school_registration_cubit.dart';
import 'auth/viewmodel/dashboard/dashboard_cubit.dart';
import 'auth/viewmodel/onboarding/onboarding_cubit.dart';

class DependencyInjector {
  static List<SingleChildWidget> providers() {
    final SchoolRegistrationRepo loadingRepo = SchoolRegistrationRepo.initial();

    return [
      FutureProvider<SchoolRegistrationRepo>(
        create: (_) => SchoolRegistrationRepo.create(),
        initialData: SchoolRegistrationRepo.initial(),
      ),
      ProxyProvider<SchoolRegistrationRepo, SchoolRegistrationService>(
        update: (_, repo, __) => repo != loadingRepo
            ? SchoolRegistrationService(repo)
            : SchoolRegistrationServiceInitial(repo),
      ),
      BlocProvider<OnboardingCubit>(create: (context) {
        final service = context.read<SchoolRegistrationService?>();
        if (service == null || service is SchoolRegistrationServiceInitial) {
          throw Exception("SchoolRegistrationService is not initialized");
        } else {
          return OnboardingCubit(service);
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
        // final service = context.read<LoginCubit?>();
        // if (service == null || service is LoginInitial) {
        //   throw Exception("Login Service is not initialized");
        // } else {
        return LoginCubit();
        // }
      }),
      BlocProvider<DashboardCubit>(create: (context) {
        // final service = context.read<LoginCubit?>();
        // if (service == null || service is LoginInitial) {
        //   throw Exception("Login Service is not initialized");
        // } else {
        return DashboardCubit();
        // }
      })
    ];
  }
}
