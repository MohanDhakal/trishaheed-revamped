import 'package:flutter/foundation.dart';
import 'package:trishaheed/model/student.dart';
import '../services/BaseApi.dart';
import '../utilities/api_routes.dart';

class StudentRepo {
  Future<StudentWrapper?> getStudentsForGrade(int classId, int page) async {
    final response = await BaseApi.createDio()
        .get(ApiRoutes.students + "$classId", {"page": page});
    List<Student> tList = <Student>[];
    StudentWrapper? student;
    response.fold((l) {
      for (var element in l.data["data"]) {
        tList.add(Student.fromMap(element));
      }
      student = StudentWrapper(
        totalStudents: l.data["total"],
        perPage: l.data["per_page"],
        currentPage: l.data["current_page"],
        lastPage: l.data['last_page'],
        student: tList,
      );
    }, (r) {
      debugPrint(r.message + r.code.toString());
    });
    return student;
  }

  Future<Student?> verifyStudent(int classId, int rollNumber) async {
    BaseApi baseApi = BaseApi.createDio();
    var response = await baseApi.post(
        {'class_id': classId, 'roll_number': rollNumber},
        ApiRoutes.verifyStudent);
    Student? std;
    response.fold((l) {
      std = Student.fromMap(l.data);
    }, (r) => debugPrint("${r.message}"));
    return std;
  }

  Future<List<Grade>> getClasses() async {
    List<Grade> tList = <Grade>[];
    BaseApi baseApi = BaseApi.createDio();
    var response = await baseApi.get(ApiRoutes.grades);
    response.fold((l) {
      for (var element in l.data) {
        final grade = Grade.fromMap(element);
        tList.add(grade);
      }
    }, (r) {
      print("Error with code: ${r.code} and message: ${r.message}");
    });
    return tList;
  }

  Future<StudentContact?> getContactForStudent(int id) async {
    BaseApi baseApi = BaseApi.createDio();
    var response = await baseApi.get('${ApiRoutes.contactForID}$id');
    StudentContact? studentContact;
    response.fold((l) {
      print(l.data);

      studentContact = StudentContact.fromMap(l.data);
    }, (r) {
      print("Error with code: ${r.code} and message: ${r.message}");
    });
    return studentContact;
  }
}
