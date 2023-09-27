// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final FocusNode _focusNode = FocusNode();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500)).then((value) async {
      await Provider.of<StudentState>(context, listen: false).getStudentList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    final size = MediaQuery.of(context).size;
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: _handleKeyEvent,
      autofocus: true,
      child: Consumer<StudentState>(builder: (context, model, child) {
        print(model.loading);
        return model.selectedStudent != null
            ? StudentDetail(
                student: model.selectedStudent!,
                onBackPressed: () {
                  model.selectedStudent = null;
                },
              )
            : (responsiveWrapper.isLargerThan(TABLET))
                ? SingleChildScrollView(
                    controller: _controller,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.0),
                        GradeChips(),
                        model.loading
                            ? SizedBox(
                                width: 50,
                                height: 50,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : (model.studentList.isEmpty)
                                ? Column(
                                    children: [
                                      SizedBox(height: size.height * 0.2),
                                      Center(
                                        child: Text(
                                            "Looks like there is no detail about the grade you selected"),
                                      ),
                                    ],
                                  )
                                : SizedBox(
                                    height: size.height * 0.8,
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 300,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 0.60,
                                      ),
                                      itemCount: model.studentList.length,
                                      itemBuilder: ((context, index) {
                                        return InkWell(
                                          onTap: (() {
                                            model.selectedStudent = model
                                                .studentList
                                                .elementAt(index);
                                          }),
                                          child: StudentWidget(
                                            student: model.studentList
                                                .elementAt(index),
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
                        ),
                        SizedBox(height: 12)
                      ],
                    ),
                  )
                : Column(
                    children: [
                      DropDownGrade(),
                      SizedBox(height: 12),
                      model.loading
                          ? SizedBox(
                              width: 50,
                              height: 50,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : (model.studentList.isEmpty)
                              ? Column(
                                  children: [
                                    SizedBox(height: size.height * 0.2),
                                    Center(
                                      child: Text(
                                          "Looks like there is no detail about the grade you selected"),
                                    ),
                                  ],
                                )
                              : SizedBox(
                                  height: size.height * 0.60,
                                  child: ListView.builder(
                                    itemCount: model.studentList.length,
                                    shrinkWrap: true,
                                    itemBuilder: ((context, index) {
                                      return InkWell(
                                        onTap: (() {
                                          model.selectedStudent = model
                                              .studentList
                                              .elementAt(index);
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
      }),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    var offset = _controller.offset;
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        if (kReleaseMode) {
          _controller.animateTo(offset - 50,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        } else {
          _controller.animateTo(offset - 50,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        }
      });
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        if (kReleaseMode) {
          _controller.animateTo(offset + 50,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        } else {
          _controller.animateTo(offset + 50,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        }
      });
    }
  }
}

class DropDownGrade extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StudentState>(builder: (context, model, child) {
      return DropdownButton<String>(
        value: GradeMap.names[model.selectedGrade],
        onChanged: (String? newValue) async {
          List<String> values = GradeMap.names.values.toList();
          for (var i = 0; i < values.length; i++) {
            if (values[i] == newValue) {
              model.selectedGrade = GradeMap.names.keys.elementAt(i);
              break;
            }
          }
          model.loading = true;
          await model.getStudentList();
          model.loading = false;
        },
        items: GradeMap.names.values.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
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
        height: responsiveWrapper.isSmallerThan(DESKTOP)
            ? size.height * 0.2
            : size.height * 0.2,
        width: size.width,
        child: Wrap(spacing: 1, runSpacing: 2, children: [
          ...List.generate(GradeMap.names.length, (index) {
            return MaterialButton(
              onPressed: () async {
                model.currentPage = 1;
                model.selectedGrade = GradeMap.names.keys.elementAt(index);
                model.loading = true;
                await model.getStudentList();
                model.loading = false;
              },
              child: Container(
                width: responsiveWrapper.isSmallerThan(DESKTOP) ? 60 : 100,
                height: responsiveWrapper.isSmallerThan(DESKTOP) ? 24 : 36,
                margin: EdgeInsets.symmetric(horizontal: 4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: model.selectedGrade ==
                          GradeMap.names.keys.elementAt(index)
                      ? Colors.blueAccent
                      : null,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black26),
                ),
                child: Text(
                  "${GradeMap.names[GradeMap.names.keys.elementAt(index)]}",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            );
          }),
        ]),
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
