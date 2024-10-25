import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/model/states/students_state.dart';
import 'package:trishaheed/model/student.dart' as studentModel;
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
      final provider = Provider.of<StudentState>(context, listen: false);
      await provider.getClasses();
      await provider.getStudentList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    final size = MediaQuery.of(context).size;
    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      autofocus: true,
      child: Consumer<StudentState>(builder: (context, model, child) {
        return model.selectedStudent != null
            ? StudentDetail(
                student: model.selectedStudent!,
                stdContact: model.studentContact,
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
                        SizedBox(height: 16.0),
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
                                          "Looks like there is no detail about the grade you selected",
                                        ),
                                      ),
                                    ],
                                  )
                                : GridView.builder(
                                    shrinkWrap: true,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: responsiveWrapper
                                              .isSmallerThan(TABLET)
                                          ? size.width * 0.8
                                          : size.width * 0.3,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      childAspectRatio: responsiveWrapper
                                              .isSmallerThan(TABLET)
                                          ? 0.8
                                          : 0.8,
                                    ),
                                    itemCount: model.studentList.length,
                                    itemBuilder: ((context, index) {
                                      return InkWell(
                                        onTap: (() async {
                                          model.studentContact = null;
                                          model.selectedStudent = model
                                              .studentList
                                              .elementAt(index);
                                          // await model.getContact();
                                        }),
                                        child: StudentWidget(
                                          student: model.studentList
                                              .elementAt(index),
                                          studentContact: model.studentContact,
                                        ),
                                      );
                                    }),
                                  ),
                        SizedBox(height: 16.0),
                        PaginatorWidget(
                          onNext: () {
                            if (model.currentPage < model.lastPage) {
                              // showLoadingDialog(context);
                              ++model.currentPage;
                              model.getStudentList().then((value) {
                                // Navigator.pop(context);
                              });
                            }
                          },
                          onPrevious: () {
                            if (model.currentPage > 1) {
                              // showLoadingDialog(context);
                              --model.currentPage;
                              model.getStudentList().then((value) {
                                // Navigator.pop(context);
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
                : SizedBox(
                    height: size.height,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropDownGrade(),
                        SizedBox(height: 12),
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
                                      Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Center(
                                          child: Text(
                                            "Looks like there is no detail about the grade you selected",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                      itemCount: model.studentList.length,
                                      shrinkWrap: true,
                                      controller: _controller,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
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
                                            child: SizedBox(
                                              width: size.width * 0.7,
                                              height: size.height * 0.6,
                                              child: StudentWidget(
                                                student:
                                                    model.studentList[index],
                                                // width: MediaQuery.of(context).size.width,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                      ],
                    ),
                  );
      }),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
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
      return model.grades.isEmpty
          ? Center(child: Text('No Students Found....'))
          : DropdownButton<studentModel.Grade>(
              value: model.selectedGrade,
              onChanged: (studentModel.Grade? newValue) async {
                model.loading = true;
                model.selectedGrade = newValue;
                await model.getStudentList();
                model.loading = false;
              },
              items: model.grades.map((e) {
                return DropdownMenuItem<studentModel.Grade>(
                  value: e,
                  child: Text(e.className),
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
        width: size.width,
        child: Wrap(
          spacing: 1,
          runSpacing: 2,
          children: model.grades.isEmpty
              ? <Widget>[Text('Loading Grades')]
              : model.grades.map((e) {
                  return MaterialButton(
                    onPressed: () async {
                      model.currentPage = 1;
                      model.selectedGrade = e;
                      model.loading = true;
                      await model.getStudentList();
                      model.loading = false;
                    },
                    child: Container(
                      width:
                          responsiveWrapper.isSmallerThan(DESKTOP) ? 60 : 100,
                      height:
                          responsiveWrapper.isSmallerThan(DESKTOP) ? 24 : 36,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:
                            model.selectedGrade == e ? Colors.blueAccent : null,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black26),
                      ),
                      child: Text(
                        "${e.className}",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                }).toList(),
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
        final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
          onPressed: onPrevious,
          child: Container(
            width: size.height*0.1,
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
        SizedBox(width: 8),
        Container(
          width: size.width*0.3,
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
        SizedBox(width: 8),
        MaterialButton(
          onPressed: onNext,
          child: Container(
            width: size.height*0.1,
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
