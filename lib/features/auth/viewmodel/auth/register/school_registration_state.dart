part of 'school_registration_cubit.dart';

sealed class SchoolRegistrationState extends Equatable {
   final Authfailure? authfailure;
  SchoolRegistrationState({this.authfailure});
  @override
  List<Object> get props => [];
}

final class SchoolRegistrationInitial extends SchoolRegistrationState {}

final class SchoolRegistrationLoading extends SchoolRegistrationState {}

final class SchoolRegistrationComplete extends SchoolRegistrationState {

}

final class SchoolRegistrationFailure extends SchoolRegistrationState {
   SchoolRegistrationFailure({Authfailure? authfailure})
      : super(authfailure: authfailure);
}
