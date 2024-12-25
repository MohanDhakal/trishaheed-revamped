part of 'dashboard_cubit.dart';

sealed class DashboardState extends Equatable {
  final int currentIndex;
  DashboardState(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}

final class DashboardInitial extends DashboardState {
  DashboardInitial(super.currentIndex);
}

final class DashboardChecking extends DashboardState {
  DashboardChecking(super.currentIndex);
}

final class DashboardComplete extends DashboardState {
  DashboardComplete(super.currentIndex);
}

final class DashboardCompleteError extends DashboardState {
  DashboardCompleteError(super.currentIndex);
}
