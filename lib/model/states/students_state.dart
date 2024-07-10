import 'package:flutter/material.dart';
import 'package:trishaheed/model/student.dart';
import 'package:trishaheed/repository/student_repo.dart';

class StudentState with ChangeNotifier {
  List<Student> studentList = [];
  Student? _selectedStudent;
  bool _loading = false;
  int _currentPage = 1;
  int _lastPage = 1;
  List<Grade> grades = [];
  Grade? _selectedGrade;
  String errorMessage = "";
  StudentContact? studentContact;

  set selectedStudent(Student? std) {
    _selectedStudent = std;
    notifyListeners();
  }

  set loading(bool trigger) {
    _loading = trigger;
    notifyListeners();
  }

  set selectedGrade(Grade? grade) {
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
  Grade? get selectedGrade => _selectedGrade;
  bool get loading => _loading;

  Student? get selectedStudent => _selectedStudent;

  Future<void> getClasses() async {
    final grades = await StudentRepo().getClasses();
    this.grades = grades;
    if (grades.isNotEmpty) this.selectedGrade = grades[0];
  }

  Future<void> getContact() async {
    if(selectedStudent!=null){
     final contact = await StudentRepo().getContactForStudent(selectedStudent!.id!);
     studentContact=contact;
     notifyListeners();
    }else{
      print('student selected is null');
    }
    //  if (grades.isNotEmpty) this.selectedGrade = grades[0];
  }

  Future<void> getStudentList() async {
    loading = true;
    if (_selectedGrade != null) {
      final response = await StudentRepo()
          .getStudentsForGrade(selectedGrade!.id, currentPage);
      if (response != null) {
        loading = false;
        studentList = response.student;
        lastPage = response.lastPage;
        currentPage = response.currentPage;
      } else {
        loading = false;
        errorMessage = "Error Occured";
        debugPrint(errorMessage);
      }
      if (selectedStudent != null) {
        if ((selectedStudent!.id) != null) {
          await StudentRepo().getContactForStudent(selectedStudent!.id!);
        }
      }
    } else {
      loading = false;
    }
  }
}
