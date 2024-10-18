import 'package:flutter/material.dart';
import '../model/Exam.dart';
import '../model/student.dart';
import 'dotted_divider.dart';

class StudentInformation extends StatelessWidget {
  final Student student;
  final Exam exam;
  final Grade grade;

  const StudentInformation({
    super.key,
    required this.student,
    required this.exam,
    required this.grade,
  });
  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    """Shree Tri-Shaheed Model Secondary School """,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    """Aandhikhola-1,Panchamool  """,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${exam.term} Examination',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'GRADE-SHEET',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'The Grade(s) SECURED BY : '.toUpperCase(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    '${student.fullName}  '.toUpperCase(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  DottedDivider(),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Date of Birth'.toUpperCase(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    '${student.dob}  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  DottedDivider(),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Registration No./Roll No.: '.toUpperCase(),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 4),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '${student.rollNumber}  ',
                          style: TextStyle(fontSize: 16),
                        ),
                        DottedDivider(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Symbol No:  ',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '${student.symbolNo}',
                          style: TextStyle(fontSize: 16),
                        ),
                        DottedDivider(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'GRADE:  ',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '${grade.classNum}',
                          style: TextStyle(fontSize: 16),
                        ),
                        DottedDivider(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Text(
          'ARE GIVEN BELOW. ',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
