import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trishaheed/model/student.dart';

class StudentState with ChangeNotifier {
  List<Student> studentList = [];
  Student? _selectedStudent;

  set selectedStudent(Student? std) {
    _selectedStudent = std;
    notifyListeners();
  }

  Student? get selectedStudent => _selectedStudent;

  Future<void> getStudentList(BuildContext context) async {
    studentList.clear();
    DefaultAssetBundle.of(context)
        .loadString("assets/data/students.json")
        .then((value) {
      var jsonData = jsonDecode(value);
      // print(jsonData["data"]);
      for (var item in jsonData["data"]) {
        studentList.add(Student.fromJson(item));
      }
      notifyListeners();
    });
  }
}
