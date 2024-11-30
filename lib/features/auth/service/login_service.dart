import 'package:trishaheed/features/auth/repository/login_repo.dart';
import 'package:trishaheed/utilities/data/credentials.dart';
import '../model/Student.dart';
import '../model/Teacher.dart';
import '../model/grade.dart';

class LoginService {
  late LoginRepo loginRepo;
  LoginService(LoginRepo repo) {
    loginRepo = repo;
  }

  Future<bool> saveCredentials(String token, String expiryDate) async {
    final tokenSaved = await loginRepo.save(CredentialsKey.accessToken, token);
    final dateSaved =
        await loginRepo.save(CredentialsKey.expiryDate, expiryDate);
    return (tokenSaved && dateSaved);
  }

/*Verify student and save token and expiry date on the local storage */
  Future<bool> studentLogin(int gradeId, int studentId, String password) async {
    final credentials =
        await loginRepo.studentLogin(gradeId, studentId, password);
    return saveCredentials(credentials[CredentialsKey.accessToken],
        credentials[CredentialsKey.expiryDate]);
  }

  Future<bool> teacherLogin(int teacherId, String password) async {
    final credentials = await loginRepo.teacherLogin(teacherId, password);
    return saveCredentials(credentials[CredentialsKey.accessToken],
        credentials[CredentialsKey.expiryDate]);
  }

  Future<List<Student>> getStudentsForGrade(int gradeId) async {
    List<Student> students = <Student>[];
    final collection = await loginRepo.getStudentsForGrade(gradeId);
    for (var element in collection) {
      students.add(Student.fromMap(element));
    }
    return students;
  }

  Future<String?> getToken() async {
    try {
      return await loginRepo.accessToken();
    } catch (e) {
      print(e);
      return null;
    }
  }
   Future<String?> getExpiry() async {
    try {
      return await loginRepo.expiryDate();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Grade>> getGrades() async {
    List<Grade> grades = [];
    List<Map<String, dynamic>> collection = await loginRepo.getGrades();
    for (var element in collection) {
      grades.add(Grade.fromMap(element));
    }
    return grades;
  }

  Future<List<Teacher>> getTeachers() async {
    List<Teacher> teachers = [];
    List<Map<String, dynamic>> collection = await loginRepo.getTeachers();
    for (var element in collection) {
      teachers.add(Teacher.fromMap(element));
    }
    return teachers;
  }
}

class LoginServiceInitial extends LoginService {
  LoginServiceInitial(super.repo);
}
