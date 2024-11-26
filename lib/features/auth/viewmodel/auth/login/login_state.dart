// ignore_for_file: must_be_immutable

part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  final Authfailure? authfailure;
  final Student? student;
  final Teacher? teacher;
  final Grade? grade;

  LoginState({this.authfailure, this.student, this.teacher, this.grade});

  @override
  List<Object?> get props => [student, authfailure, teacher, grade];
}

final class LoginInitial extends LoginState {
  LoginInitial({Grade? grade})
      : super(authfailure: null, grade: grade, student: null, teacher: null);
}

final class LoginReady extends LoginState {
  LoginReady({Grade? grade, Student? std, Teacher? teacher})
      : super(grade: grade, student: std, teacher: teacher);
}

final class LoginLoading extends LoginState {}

final class LoginComplete extends LoginState {}

final class LoginFailure extends LoginState {
  LoginFailure({Authfailure? authfailure}) : super(authfailure: authfailure);
}
