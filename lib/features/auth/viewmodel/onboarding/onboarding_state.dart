part of 'onboarding_cubit.dart';

sealed class OnboardingState extends Equatable {
  final String? url;
  final String? token;
  final String? expiry;
  const OnboardingState({this.url,this.token,this.expiry});

  @override
  List<Object> get props => [];
}

final class OnboardingInitial extends OnboardingState {}
final class OnboardingChecking extends OnboardingState {}
final class OnboardingComplete extends OnboardingState {
  OnboardingComplete({required url, required token, required expiry}):super(url: url);
}
final class OnboardingError extends OnboardingState {}



