import 'package:flutter/material.dart';
import 'package:trishaheed/model/student.dart';
import 'package:trishaheed/repository/student_repo.dart';

class StudentState with ChangeNotifier {
  List<Student> studentList = [];
  Student? _selectedStudent;
  bool _loading = false;
  int _currentPage = 1;
  int _lastPage = 1;

  int _selectedGrade = 1;
  String errorMessage = "";

  set selectedStudent(Student? std) {
    _selectedStudent = std;
    notifyListeners();
  }

  set loading(bool trigger) {
    _loading = trigger;
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
    _lastPage = page;
  }

  int get currentPage => _currentPage;
  int get lastPage => _lastPage;
  int get selectedGrade => _selectedGrade;
  bool get loading => _loading;

  Student? get selectedStudent => _selectedStudent;

  Future<void> getStudentList() async {
    loading = true;
    final response =
        await StudentRepo().getStudentsForGrade(selectedGrade, currentPage);
    if (response != null) {
      loading = false;
      studentList = response.students;
      lastPage = response.lastPage;
      currentPage = response.currentPage;
    } else {
      loading = false;
      errorMessage = "Error Occured";
      debugPrint(errorMessage);
    }
  }
}
