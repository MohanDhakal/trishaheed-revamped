import 'package:flutter/foundation.dart';
import 'package:trishaheed/model/student.dart';
import '../services/BaseApi.dart';
import '../utilities/api_routes.dart';

class StudentRepo {
  Future<StudentDetail?> getStudentsForGrade(int grade, int page) async {
    final response = await BaseApi.createDio()
        .get(ApiRoutes.students + "$grade", {"page": page});
    StudentDetail? student;
    response.fold((l) {
      student = StudentDetail.fromJson(l.data);
    }, (r) {
      debugPrint(r.message + r.code.toString());
    });
    return student;
  }
}
