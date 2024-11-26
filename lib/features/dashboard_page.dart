import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/viewmodel/auth/login/login_cubit.dart';
import 'auth/viewmodel/dashboard/dashboard_cubit.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DashboardCubit>();

    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dashboard Here"),
          actions: [
            GestureDetector(
              onTap: () =>cubit.reset(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.logout,
                ),
              ),
            )
          ],
        ),
        body: Center(
          child: Container(
            child: Text('Hello There'),
          ),
        ),
      ),
    );
  }
}
