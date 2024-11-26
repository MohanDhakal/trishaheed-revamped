import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:trishaheed/features/auth/viewmodel/dashboard/dashboard_cubit.dart';
import 'package:trishaheed/features/dependency_injector.dart';
import 'package:trishaheed/features/home_page.dart';

import 'features/auth/repository/school_registration_repo.dart';
import 'features/auth/service/school_registration_service.dart';
import 'features/auth/viewmodel/auth/login/login_cubit.dart';
import 'features/auth/viewmodel/auth/register/school_registration_cubit.dart';
import 'features/auth/viewmodel/onboarding/onboarding_cubit.dart';

void main() {
  runApp(
    ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return HomePage();
      },
    ),
  );
}
