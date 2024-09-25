import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/widgets/results_footer.dart';
import '../model/Exam.dart';
import '../model/Result.dart';
import '../model/student.dart';
import '../repository/results_repo.dart';
import '../repository/student_repo.dart';
import '../widgets/results_table.dart';
import '../widgets/student_information.dart';

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
  final _verticalScrollController = ScrollController();

  @override
  void initState() {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final wrapper = ResponsiveWrapper.of(context);
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
        scrollDirection: Axis.vertical,
        controller: _verticalScrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: FormBuilder(
                key: _formKey,
                child: ResponsiveRowColumn(
                  columnMainAxisAlignment: MainAxisAlignment.start,
                  columnCrossAxisAlignment: CrossAxisAlignment.start,
                  layout: wrapper.isSmallerThan(TABLET)
                      ? ResponsiveRowColumnType.COLUMN
                      : ResponsiveRowColumnType.ROW,
                  rowCrossAxisAlignment: CrossAxisAlignment.center,
                  rowMainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    wrapper.isSmallerThan(TABLET)
                        ? ResponsiveRowColumnItem(child: SizedBox(width: 16))
                        : ResponsiveRowColumnItem(child: SizedBox()),
                    ResponsiveRowColumnItem(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        width: wrapper.isSmallerThan(TABLET)
                            ? size.width * 0.5
                            : size.width * 0.15,
                        child: FormBuilderDropdown(
                          name: 'Academic Year',
                          initialValue: selectedYear,
                          style: TextStyle(fontSize: 12),
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
                    ),
                    ResponsiveRowColumnItem(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        width: wrapper.isSmallerThan(TABLET)
                            ? size.width * 0.5
                            : size.width * 0.2,
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
                    ),
                    ResponsiveRowColumnItem(
                      child: Container(
                        width: wrapper.isSmallerThan(TABLET)
                            ? size.width * 0.5
                            : size.width * 0.3,
                        padding: EdgeInsets.symmetric(horizontal: 8),
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
                    ),
                    ResponsiveRowColumnItem(
                      child: Container(
                        width: wrapper.isSmallerThan(TABLET)
                            ? size.width * 0.5
                            : size.width * 0.3,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: FormBuilderTextField(
                          name: 'Roll Number',
                          controller: _rollNoController,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(labelText: 'Roll Number'),
                          keyboardType: TextInputType.number,
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.integer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 222, 54, 244),
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
                        debugPrint('Student is verified, now get the result');
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
                              cumulativeGP +=
                                  results[i].gradePoint! * results[i].credit!;
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
                SizedBox(width: 16),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor:
                //         results.isEmpty ? Colors.grey : Colors.blueAccent,
                //   ),
                //   onPressed: () async {
                //     if (results.isNotEmpty) {
                //       showPDF(context);
                //     }
                //   },
                //   child: Text(
                //     'Print Result to PDF',
                //     style: TextStyle(
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
              ],
            ),
            Text(
              errorMessage,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            (selectedStudent != null &&
                    selectedExam != null &&
                    selectedGrade != null)
                ? Column(
                    children: [
                      StudentInformation(
                        student: selectedStudent!,
                        exam: selectedExam!,
                        grade: selectedGrade!,
                      ),
                      results.isNotEmpty
                          ? ResultsTable(
                              results: results,
                              exam: selectedExam!,
                              student: selectedStudent!,
                            )
                          : SizedBox()
                    ],
                  )
                : SizedBox(),
            SizedBox(height: 8),
            Divider(
              height: 1,
              color: Colors.black,
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
            Divider(
              height: 1,
              color: Colors.black,
            ),
            ResultsFooter(
              checkedBy: "",
              preparedBy: "Pabitra Poudel",
              headMaster: "Tek Nath Khanal",
              issuedDate:
                  "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}",
            )
          ],
        ),
      ),
    );
  }
}
