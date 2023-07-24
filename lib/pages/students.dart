import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/model/states/students_state.dart';
import 'package:trishaheed/widgets/student.dart';

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
      Provider.of<StudentState>(context, listen: false).getStudentList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);

    return responsiveWrapper.isLargerThan(TABLET)
        ? Consumer<StudentState>(builder: (context, model, child) {
            return model.selectedStudent != null
                ? StudentDetail(
                    student: model.selectedStudent!,
                    onBackPressed: () {
                      model.selectedStudent = null;
                    },
                  )
                : (model.studentList.isEmpty)
                    ? SizedBox(
                        child: Center(
                          child: Text("No Students Detail Available"),
                        ),
                      )
                    : (responsiveWrapper.isLargerThan(TABLET))
                        ? GridView.builder(
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
                          )
                        : ListView.builder(
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
                          );
          })
        : SizedBox();
  }
}
