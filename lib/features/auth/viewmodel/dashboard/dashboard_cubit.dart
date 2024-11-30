import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trishaheed/features/routes.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  void reset(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.splashScreen, (Route<dynamic> route) => false);
  }

  @override
  Future<void> close() {    
    return super.close();
  }
}
