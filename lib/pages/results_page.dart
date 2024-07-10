import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../model/Exam.dart';
import '../model/Result.dart';
import '../model/student.dart';
import '../repository/results_repo.dart';
import '../repository/student_repo.dart';

class ViewResult extends StatefulWidget {
  const ViewResult({super.key});

  @override
  State<ViewResult> createState() => _ViewResultState();
}

class _ViewResultState extends State<ViewResult> {
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController _rollNoController = TextEditingController();

  bool _loading = false;
  final studentRepo = StudentRepo();
  final resultsRepo = ResultsRepo();
  List<Exam> exams = [];
  List<Grade> grades = [];
  List<Result> results = [];
  List<int> academicYears = [];
  String errorMessage = " ";
  Exam? selectedExam;
  Grade? selectedGrade;
  Student? selectedStudent;
  int? selectedYear;
  double cumulativeGP = 0.0;
  double totalCredits = 0.0;

  @override
  void initState() {
    super.initState();
    resultsRepo.getAcademicYears().then((value) {
      setState(() {
        // academicYears = value.sublist(value.length - 2);
        academicYears = value;
      });
    });
    studentRepo.getClasses().then((value) {
      setState(() {
        grades = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 8, 133, 250),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            '''Welcome to Tri-Shaheed  Results Management Systems. ''',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(width: 16),
            SizedBox(
              height: size.height * 0.3,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  FormBuilder(
                    key: _formKey,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.spaceEvenly,

                      runSpacing: 4,
                      // runAlignment: Wrap,
                      children: [
                        SizedBox(
                          width: size.width * 0.2,
                          child: FormBuilderDropdown(
                            name: 'Academic Year',
                            initialValue: selectedYear,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            onChanged: (int? year) {
                              selectedYear = year;
                              if (year != null) {
                                resultsRepo
                                    .getExams(academicYear: year)
                                    .then((value) {
                                  setState(() {
                                    exams = value;
                                  });
                                });
                              }
                            },
                            decoration:
                                InputDecoration(labelText: 'Academic Year'),
                            items: academicYears.map(
                              (year) {
                                return DropdownMenuItem(
                                  value: year,
                                  child: Text(year.toString()),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.2,
                          child: FormBuilderDropdown(
                            name: 'Exam Term',
                            initialValue: selectedExam,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            onChanged: (Exam? value) {
                              selectedExam = value;
                            },
                            decoration: InputDecoration(labelText: 'Exam Term'),
                            items: exams.map(
                              (exam) {
                                return DropdownMenuItem(
                                  value: exam,
                                  child: Text(exam.term),
                                );
                              },
                            ).toList(),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.4,
                          child: FormBuilderDropdown(
                            name: 'Grade',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            initialValue: selectedGrade,
                            onChanged: (Grade? value) {
                              selectedGrade = value;
                            },
                            decoration: InputDecoration(labelText: 'Grade'),
                            items: grades.map(
                              (grade) {
                                return DropdownMenuItem(
                                  value: grade,
                                  child: Text('${grade.className}'),
                                );
                              },
                            ).toList(),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.2,
                          child: FormBuilderTextField(
                            name: 'Roll Number',
                            controller: _rollNoController,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            decoration:
                                InputDecoration(labelText: 'Roll Number'),
                            keyboardType: TextInputType.number,
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.integer(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 222, 54, 244),
                        ),
                        onPressed: () async {
                          cumulativeGP = 0;
                          totalCredits = 0;
                          setState(() {
                            _loading = true;
                            errorMessage = '';
                          });

                          if (selectedGrade != null && selectedExam != null) {
                            Student? std = await studentRepo.verifyStudent(
                              selectedGrade!.id,
                              int.parse(_rollNoController.text),
                            );
                            selectedStudent = std;
                            if (std != null) {
                              debugPrint(
                                  'Student is verified, now get the result');
                              final result = {
                                'student_id': std.id!,
                                'exam_id': selectedExam!.id!
                              };
                              results = await resultsRepo.displayResult(result);
                              for (var i = 0; i < results.length; i++) {
                                if (results[i].gradePoint == 0) {
                                  cumulativeGP = 0.0;
                                  break;
                                } else {
                                  if (results[i].gradePoint != null &&
                                      results[i].credit != null) {
                                    cumulativeGP += results[i].gradePoint! *
                                        results[i].credit!;
                                    totalCredits += results[i].credit!;
                                  }
                                }
                              }
                            } else {
                              setState(() {
                                errorMessage = 'Student Cannot be Verified';
                              });
                            }
                            setState(() {
                              _loading = false;
                            });
                          }
                        },
                        child: _loading
                            ? CircularProgressIndicator(
                                color: Color.fromARGB(255, 5, 76, 134))
                            : Text(
                                'Show Result',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ],
                  ),
                  Text(
                    errorMessage,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            _loading
                ? CircularProgressIndicator()
                : (selectedExam != null && selectedStudent != null)
                    ? Column(
                        children: [
                          (selectedStudent != null &&
                                  selectedExam != null &&
                                  selectedGrade != null)
                              ? StudentInformation(
                                  student: selectedStudent!,
                                  exam: selectedExam!,
                                  grade: selectedGrade!,
                                )
                              : SizedBox(),
                          ResultsTable(
                            results: results,
                            exam: selectedExam!,
                            student: selectedStudent!,
                          ),
                          (cumulativeGP == 0 || totalCredits == 0)
                              ? Text(
                                  'Not Available',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'GPA  : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      " ${(cumulativeGP / totalCredits).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                          Text(
                            '''1. 1 Cr.Hr equals 32 Clock Hrs.                     
                            ''',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '''2. TH: Theory,IN: Internal.                     
                            ''',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
          ],
        ),
      ),
    );
  }
}

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
      children: [
        Text(
          'Shree Tri-Shaheed Model Secondary School',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${exam.term} term  Examination',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Gradesheet',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name: ${student.fullName}  ',
              style: TextStyle(fontSize: 12),
            ),
            Text(
              'DOB: ${student.dob}  ',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Roll Number: ${student.rollNumber}  ',
                style: TextStyle(fontSize: 12)),
            SizedBox(height: 4),
            Text(
              'Grade: ${grade.classNum} (${grade.className})  ',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 4),
            Text(
              'Exam: ${exam.term} Examination  ',
              style: TextStyle(fontSize: 12),
            ),
          ],
        )
      ],
    );
  }
}

class ResultsTable extends StatefulWidget {
  final List<Result> results;
  final Exam exam;
  final Student student;
  const ResultsTable({
    super.key,
    required this.results,
    required this.exam,
    required this.student,
  });

  @override
  State<ResultsTable> createState() => _ResultsTableState();
}

class _ResultsTableState extends State<ResultsTable> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      // decoration: ,
      dataRowMinHeight: 16,
      dataRowMaxHeight: 28,
      columns: const <DataColumn>[
        DataColumn(label: Text('Subjects')),
        DataColumn(
          label: RotatedBox(
            quarterTurns: 3,
            child: Text(
              'Credit Hr.',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataColumn(
          label: RotatedBox(
            quarterTurns: 3,
            child: Text(
              'Grade',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataColumn(
          label: RotatedBox(
            quarterTurns: 3,
            child: Text(
              'Grade Point',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataColumn(
          label: RotatedBox(
            quarterTurns: 3,
            child: Text(
              'Final Grade',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataColumn(
          label: RotatedBox(
            quarterTurns: 3,
            child: Text(
              'Remarks',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
      rows: widget.results
          .map(
            (result) => DataRow(
              cells: <DataCell>[
                DataCell(
                  Text(
                    '${result.subjectName}(${result.marksType})',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                DataCell(Text(
                  '${result.credit ?? 0.0}',
                  style: TextStyle(fontSize: 10),
                )),
                DataCell(Text(
                  result.grade ?? 'NG',
                  style: TextStyle(fontSize: 10),
                )),
                DataCell(Text(
                  '${result.gradePoint ?? 0.0}',
                  style: TextStyle(fontSize: 10),
                )),
                DataCell(Text(
                  result.grade ?? 'NG',
                  style: TextStyle(fontSize: 10),
                )),
                DataCell(Text(' ')),
              ],
            ),
          )
          .toList(),
    );
  }
}
