import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trishaheed/features/auth/service/validation_service.dart';
import '../../../model/AuthFailure.dart';
import '../../../model/Student.dart';
import '../../../model/Teacher.dart';
import '../../../model/grade.dart';

part 'login_state.dart';

enum LoginAs { Teacher, Student }

class LoginCubit extends Cubit<LoginState> {
  List<Student> students = [];
  Student? selectedStudent;
  Teacher? selectedTeacher;
  Grade? selectedGrade;
  List<Teacher> teachers = [];
  List<Grade> grades = [];

  LoginCubit() : super(LoginInitial());

  Future<void> getStudentsForGrade() async {
    students.clear();
    if (selectedGrade != null) {
      Future.delayed(Duration(seconds: 2));
      students.addAll([
        Student(rollNumber: 1, name: "Mohan Dhakal"),
        Student(rollNumber: 2, name: "Suraj Chaudhary")
      ]);
      emit(LoginReady(std: students[0], grade: selectedGrade));
    }
  }

  Future<void> getGrades() async {
    grades.clear();
    Future.delayed(Duration(seconds: 2));
    grades.addAll([
      Grade(num: 1, name: "One"),
      Grade(num: 1, name: "Two"),
    ]);
    emit(LoginInitial());
  }

  Future<void> getTeachers() async {
    Future.delayed(Duration(seconds: 2));
    teachers.clear();
    teachers.addAll([
      Teacher(id: 1, name: "Er. Mohan Dhakal", age: 24),
      Teacher(id: 2, name: "Er. Suraj Chaudhary", age: 23)
    ]);
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
    print(grade);
    selectedGrade = grade;
    await getStudentsForGrade();
  }

  Future<void> submitLoginForm(String password) async {
    emit(LoginLoading());
    if (selectedStudent != null) {
      final nameValidation =
          ValidationService.validateName(selectedStudent!.name);
      final passwordValidation = ValidationService.validatePassword(password);
      if (nameValidation == null && passwordValidation == null) {
        print("${selectedStudent!.name}");
        await Future.delayed(Duration(seconds: 2));
        emit(LoginComplete());
      } else {
        emit(LoginFailure(
            authfailure: Authfailure(100, "Something went wrong")));
      }
    } else if (selectedTeacher != null) {
      print("${selectedTeacher!.name}");
      final nameValidation =
          ValidationService.validateName(selectedTeacher!.name);
      final passwordValidation = ValidationService.validatePassword(password);
      if (nameValidation == null && passwordValidation == null) {
        // print("inside validation");
        await Future.delayed(Duration(seconds: 2));
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

  @override
  Future<void> close() {
    return super.close();
  }
}
