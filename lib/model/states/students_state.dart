import 'package:flutter/material.dart';
import 'package:trishaheed/model/student.dart';
import 'package:trishaheed/repository/student_repo.dart';

class StudentState with ChangeNotifier {
  List<Student> studentList = [];
  Student? _selectedStudent;

  int _currentPage = 1;
  int _lastPage = 1;

  int _selectedGrade = 3;
  String errorMessage = "";

  set selectedStudent(Student? std) {
    _selectedStudent = std;
    notifyListeners();
  }

  set selectedGrade(int grade) {
    _selectedGrade = grade;
    notifyListeners();
  }

  set currentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  set lastPage(int page) {
    _currentPage = page;
  }

  int get currentPage => _currentPage;
  int get lastPage => _lastPage;
  int get selectedGrade => _selectedGrade;

  Student? get selectedStudent => _selectedStudent;

  Future<void> getStudentList() async {
    final response = await StudentRepo()
        .getStudentsForGrade(selectedGrade, page: currentPage);
    if (response != null) {
      // print(response.students);
      studentList = response.students;
      lastPage = response.lastPage;
      currentPage = response.currentPage;
    } else {
      errorMessage = "Error Occured";
      debugPrint(errorMessage);
    }
  }
}
