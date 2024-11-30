import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trishaheed/features/auth/service/login_service.dart';
import 'package:trishaheed/features/auth/service/validation_service.dart';
import '../../../model/AuthFailure.dart';
import '../../../model/Student.dart';
import '../../../model/Teacher.dart';
import '../../../model/grade.dart';
part 'login_state.dart';

enum LoginAs { Teacher, Student }

class LoginCubit extends Cubit<LoginState> {
  final LoginService service;
  LoginCubit(this.service) : super(LoginInitial());
  List<Student> students = [];
  Student? selectedStudent;
  Teacher? selectedTeacher;
  Grade? selectedGrade;
  List<Teacher> teachers = [];
  List<Grade> grades = [];

  void reset() {
    emit(LoginInitial());
  }

  Future<void> getStudentsForGrade() async {
    students.clear();
    if (selectedGrade != null) {
      if (selectedGrade!.id != null) {
        students = await service.getStudentsForGrade(selectedGrade!.id!);
        emit(LoginReady(std: students[0], grade: selectedGrade));
      } else {
        emit(LoginFailure());
      }
    }
  }

  Future<void> getGrades() async {
    grades.clear();
    grades = await service.getGrades();
    emit(LoginInitial());
  }

  Future<void> getTeachers() async {
    teachers.clear();
    teachers = await service.getTeachers();
    emit(LoginInitial());
  }

  void setSelectedStudent(Student? std) {
    selectedStudent = std;
    emit(LoginReady(std: std, teacher: null, grade: selectedGrade));
  }

  void setSelectedTeacher(Teacher? teacher) {
    selectedTeacher = teacher;
    emit(LoginReady(teacher: teacher, std: null, grade: null));
  }

  Future<void> setSelectedGrade(Grade? grade) async {
    selectedGrade = grade;
    await getStudentsForGrade();
  }
/* 
  Validates user detail and password of the user
  and sends validated data to loginservice .
  on sucess login will be sucessfull and user will be redirected to dashboardpage 
*/

  Future<void> submitLoginForm(String password) async {
    emit(LoginLoading());
    if (selectedStudent != null) {
      final nameValidation =
          ValidationService.validateName(selectedStudent!.name);
      final passwordValidation = ValidationService.validatePassword(password);
      // if name and pasword are validated
      if (nameValidation == null && passwordValidation == null) {
        bool loggedIn = await service.studentLogin(
            selectedGrade!.id!, selectedStudent!.id!, password);
        loggedIn ? emit(LoginComplete()) : emit(LoginFailure());
      } else {
        emit(LoginFailure(
            authfailure: Authfailure(100, "Something went wrong")));
      }
    } else if (selectedTeacher != null) {
      // print("${selectedTeacher!.name}");
      final nameValidation =
          ValidationService.validateName(selectedTeacher!.name);
      final passwordValidation = ValidationService.validatePassword(password);
      if (nameValidation == null && passwordValidation == null) {
        await service.teacherLogin(selectedTeacher!.id!, password);
        emit(LoginComplete());
      } else {
        emit(
          LoginFailure(
            authfailure: Authfailure(100, "Validation Error Occurred"),
          ),
        );
      }
    } else {
      emit(LoginFailure(authfailure: Authfailure(100, "Something went wrong")));
    }
  }

  String? validatePassword(String? password) {
    return password == null
        ? "Password Cannot be null"
        : ValidationService.validatePassword(password);
  }
}
