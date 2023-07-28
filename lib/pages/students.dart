import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/model/states/students_state.dart';
import 'package:trishaheed/utilities/grade_map.dart';
import 'package:trishaheed/widgets/student.dart';
import '../utilities/loading_dialog.dart';
import 'student_detail.dart';

class Students extends StatefulWidget {
  const Students({Key? key}) : super(key: key);

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      Provider.of<StudentState>(context, listen: false).getStudentList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    final size = MediaQuery.of(context).size;
    return Consumer<StudentState>(builder: (context, model, child) {
      return model.selectedStudent != null
          ? StudentDetail(
              student: model.selectedStudent!,
              onBackPressed: () {
                model.selectedStudent = null;
              },
            )
          : (responsiveWrapper.isLargerThan(TABLET))
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.0),
                    GradeChips(),
                    (model.studentList.isEmpty)
                        ? Column(
                            children: [
                              SizedBox(height: size.height * 0.2),
                              Center(
                                child: Text("No Students Detail Available"),
                              ),
                            ],
                          )
                        : SizedBox(
                            height: size.height * 0.6,
                            child: GridView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(10.0),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 300,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.66,
                              ),
                              itemCount: model.studentList.length,
                              itemBuilder: ((context, index) {
                                return InkWell(
                                  onTap: (() {
                                    model.selectedStudent =
                                        model.studentList.elementAt(index);
                                  }),
                                  child: StudentWidget(
                                    student: model.studentList.elementAt(index),
                                  ),
                                );
                              }),
                            ),
                          ),
                    PaginatorWidget(
                      onNext: () {
                        if (model.currentPage < model.lastPage) {
                          showLoadingDialog(context);
                          ++model.currentPage;
                          model.getStudentList().then((value) {
                            Navigator.pop(context);
                          });
                        }
                      },
                      onPrevious: () {
                        if (model.currentPage > 1) {
                          showLoadingDialog(context);
                          --model.currentPage;
                          model.getStudentList().then((value) {
                            Navigator.pop(context);
                          });
                        }
                      },
                      currentPage: model.currentPage,
                      lastPage: model.lastPage,
                    )
                  ],
                )
              : Column(
                  children: [
                    GradeChips(),
                    SizedBox(
                      height: size.height * 0.65,
                      child: ListView.builder(
                        itemCount: model.studentList.length,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: (() {
                              model.selectedStudent =
                                  model.studentList.elementAt(index);
                            }),
                            onHover: ((value) {}),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 8.0),
                              child: StudentWidget(
                                student: model.studentList[index],
                                // width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                );
    });
  }
}

class GradeChips extends StatelessWidget {
  const GradeChips({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final responsiveWrapper = ResponsiveWrapper.of(context);

    return Consumer<StudentState>(builder: (context, model, child) {
      return SizedBox(
        height: responsiveWrapper.isSmallerThan(TABLET)
            ? size.height * 0.2
            : size.height * 0.1,
        width: size.width,
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 8.0,
          children: List.generate(GradeMap.names.length, (index) {
            return MaterialButton(
              onPressed: () {
                showLoadingDialog(context);
                model.currentPage = 1;
                model.selectedGrade = GradeMap.names.keys.elementAt(index);
                model.getStudentList().then((value) {
                  Navigator.pop(context);
                });
              },
              child: Container(
                width: responsiveWrapper.isSmallerThan(TABLET) ? 80 : 100,
                height: responsiveWrapper.isSmallerThan(TABLET) ? 24 : 36,
                margin: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: model.selectedGrade ==
                            GradeMap.names.keys.elementAt(index)
                        ? Colors.blueAccent
                        : null,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black26)),
                child: Text(
                    "${GradeMap.names[GradeMap.names.keys.elementAt(index)]}"),
              ),
            );
          }),
        ),
      );
    });
  }
}

class PaginatorWidget extends StatelessWidget {
  final Function() onNext;
  final Function() onPrevious;
  final int currentPage;
  final int lastPage;
  PaginatorWidget({
    super.key,
    required this.onNext,
    required this.onPrevious,
    required this.currentPage,
    required this.lastPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
          onPressed: onPrevious,
          child: Container(
            width: 100,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Text("Previous"),
          ),
        ),
        SizedBox(width: 12),
        Container(
          width: 100,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: Text(
            "$currentPage of $lastPage",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(width: 12),
        MaterialButton(
          onPressed: onNext,
          child: Container(
            width: 100,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Text("Next"),
          ),
        ),
      ],
    );
  }
}
