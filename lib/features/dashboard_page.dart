import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trishaheed/features/dashboard/views/screens/landing_page.dart';
import '../dashboard_cubit.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DashboardCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard Here"),
        actions: [
          GestureDetector(
            onTap: () => cubit.reset(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.logout,
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return buildBody(state.currentIndex);
        },
      ),
      bottomNavigationBar: BlocSelector<DashboardCubit, DashboardState, int>(
        selector: (value) {
          return value.currentIndex;
        },
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state,
            onTap: (index){
              cubit.onTabSelected(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Students',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildBody(int index) {
    switch (index) {
      case 0:
        return LandingPage();
      case 1:
        return Center(child: Text('Profile Screen'));
      case 2:
        return Center(child: Text('Settings Screen'));
      default:
        return LandingPage();
    }
  }
}
