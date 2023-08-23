import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:trishaheed/model/student.dart';

class StudentData extends DataTableSource {
  late List<Student> studentList;
  StudentData.empty() {
    studentList = [];
  }
  StudentData();
//TODO: Modify this method to accept grade number and extract detail of all the studnets.

  Future<StudentData> addStudent() async {
    Future.delayed(Duration(seconds: 2));
    for (var i = 1; i < 10; i++) {
      studentList.add(
        Student("Mohan Dhakal $i", i, i + 1, i, "dob", "joinedAt", 1),
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
        DataCell(Text(student.fullName)),
        DataCell(Text(student.joinedAt.toString())),
        DataCell(Text(student.dob.toString())),
        DataCell(Text(student.guardianContact.toString())),
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
