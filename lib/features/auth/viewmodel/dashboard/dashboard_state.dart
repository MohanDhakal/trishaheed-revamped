part of 'dashboard_cubit.dart';

sealed class DashboardState extends Equatable {
  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {}

final class DashboardChecking extends DashboardState {}

final class DashboardComplete extends DashboardState {}

final class DashboardCompleteError extends DashboardState {}
