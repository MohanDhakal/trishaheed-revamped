import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:trishaheed/model/student.dart';

class StudentData extends DataTableSource {
  late List<Student> studentList;
  StudentData.empty() {
    studentList = [];
  }
  StudentData();

  Future<StudentData> addStudent() async {
    Future.delayed(Duration(seconds: 2));
    for (var i = 1; i < 5; i++) {
      studentList.add(
        Student(
            name: "Mohan Dhakal",
            grade: 5,
            rollNumber: i,
            latest_Gpa: 3.5,
            joinedDate: DateTime.now(),
            dob: DateTime(2000),
            parentName: "Parents Name"),
      );
    }
    return StudentData();
  }

  @override
  DataRow? getRow(int index) {
    final student = studentList[index];
    return DataRow2.byIndex(
      index: index,
      selected: false,
      cells: [
        DataCell(Text(student.name)),
        DataCell(Text(student.joinedDate.toString())),
        DataCell(Text(student.dob.toString())),
        DataCell(Text(student.parentName.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount {
    return studentList.length;
  }

  @override
  int get selectedRowCount => 0;
}
