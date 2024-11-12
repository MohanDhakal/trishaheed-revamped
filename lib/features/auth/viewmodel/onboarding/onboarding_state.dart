part of 'onboarding_cubit.dart';

sealed class OnboardingState extends Equatable {
  final String? url;
  const OnboardingState({this.url});

  @override
  List<Object> get props => [];
}

final class OnboardingInitial extends OnboardingState {}
final class OnboardingChecking extends OnboardingState {}
final class OnboardingComplete extends OnboardingState {
  OnboardingComplete({required url}):super(url: url);
}
final class OnboardingError extends OnboardingState {}



