import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trishaheed/features/auth/viewmodel/onboarding/onboarding_cubit.dart';
import 'package:trishaheed/features/auth/views/screen/auth_error_screen.dart';
import 'package:trishaheed/features/auth/views/screen/school_registration_screen.dart';
import 'package:trishaheed/features/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late OnboardingCubit _onboardingCubit;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    // Define the animation as a scaling (size-changing) animation
    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Set a delay to navigate to the next screen
    Future.delayed(Duration(seconds: 1), () {
      _onboardingCubit = context.read<OnboardingCubit>();

      _onboardingCubit.findSchoolUrl();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingInitial) {
          return Scaffold(
            backgroundColor: Colors.blueAccent,
            body: Center(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: child,
                  );
                },
                child: Image.asset('assets/images/logo.png',
                    width: 150, height: 150),
              ),
            ),
          );
        } else if (state is OnboardingChecking) {
          return Scaffold(
            backgroundColor: Colors.blueAccent,
            body: Center(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: child,
                  );
                },
                child: Image.asset('assets/images/logo.png',
                    width: 150, height: 150),
              ),
            ),
          );
        } else if (state is OnboardingComplete) {
          return SchoolRegistrationScreen();
        } else if (state is OnboardingError) {
          return AuthErrorScreen(onRetry: () {
            Navigator.pushNamed(context, Routes.schoolRegistration);
          });
        } else {
          return SizedBox(
            child: Center(
              child: Text("Unexpected Error Occured"),
            ),
          );
        }
      },
    );
  }
}
