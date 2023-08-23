import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/model/staff.dart' as s;
import 'package:trishaheed/pages/staff_detail.dart';
import 'package:trishaheed/repository/staff_repo.dart';
import 'package:trishaheed/widgets/staff.dart';

class TeacherStaff extends StatefulWidget {
  final Function(TeacherStaff teacherStaff) onClick;
  const TeacherStaff({Key? key, required this.onClick}) : super(key: key);

  @override
  State<TeacherStaff> createState() => _TeacherStaffState();
}

class _TeacherStaffState extends State<TeacherStaff> {
  List<s.Staff> teacherList = [];
  s.Staff? selectedStaff;
  bool _loading = true;
  int lastPage = 1;
  int currentPage = 1;
  @override
  void initState() {
    StaffRepo().getStaffList(page: 1).then((value) {
      if (value != null) {
        setState(() {
          teacherList = value.staffs;
          lastPage = value.lastPage;
          currentPage = value.currentPage;
          _loading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    final size = MediaQuery.of(context).size;
    return selectedStaff != null
        ? StaffDetail(
            staff: selectedStaff!,
            onBackPressed: () {
              setState(() => selectedStaff = null);
            },
          )
        : _loading
            ? SizedBox(
                width: 50,
                height: 50,
                child: Center(child: CircularProgressIndicator()),
              )
            : (teacherList.isEmpty)
                ? SizedBox(
                    child: Center(
                      child: Text("Could not find teacher list"),
                    ),
                  )
                : responsiveWrapper.isLargerThan(TABLET)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: size.height * 0.65,
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
                              itemCount: teacherList.length,
                              itemBuilder: ((context, index) {
                                return InkWell(
                                  onTap: (() {
                                    setState(() {
                                      selectedStaff =
                                          teacherList.elementAt(index);
                                    });
                                  }),
                                  onHover: ((value) {}),
                                  child: Staff(
                                    staff: teacherList[index],
                                  ),
                                );
                              }),
                            ),
                          ),
                          PaginatorWidget(
                            onNext: () async {
                              if (currentPage < lastPage) {
                                currentPage++;
                                setState(() => _loading = true);
                                final local = await StaffRepo()
                                    .getStaffList(page: currentPage);
                                if (local != null) {
                                  teacherList = local.staffs;
                                  currentPage = local.currentPage;
                                  lastPage = local.lastPage;
                                  setState(() => _loading = false);
                                }
                              }
                            },
                            onPrevious: () async {
                              if (currentPage > 1) {
                                currentPage--;
                                setState(() => _loading = true);
                                final local = await StaffRepo()
                                    .getStaffList(page: currentPage);
                                if (local != null) {
                                  teacherList = local.staffs;
                                  currentPage = local.currentPage;
                                  lastPage = local.lastPage;
                                  setState(() => _loading = false);
                                }
                              }
                            },
                            currentPage: currentPage,
                            lastPage: lastPage,
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height * 0.8,
                            child: ListView.builder(
                              itemCount: teacherList.length,
                              shrinkWrap: true,
                              itemBuilder: ((context, index) {
                                return InkWell(
                                  onTap: (() {
                                    selectedStaff =
                                        teacherList.elementAt(index);
                                    setState(() => null);
                                  }),
                                  onHover: ((value) {
                                    // setState(
                                    //   () {
                                    //     if (teacherList[index].position ==
                                    //         Position.passive) {
                                    //       teacherList[index].position = Position.hovered;
                                    //       // print("reached at 1");
                                    //     } else {
                                    //       teacherList[index].position = Position.passive;
                                    //       // print("reached at 2");
                                    //     }
                                    //   },
                                    // );
                                  }),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 8.0),
                                    child: Staff(
                                      staff: teacherList[index],
                                      // width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          PaginatorWidget(
                            onNext: () async {
                              if (currentPage < lastPage) {
                                currentPage++;
                                setState(() => _loading = true);
                                final local = await StaffRepo()
                                    .getStaffList(page: currentPage);
                                if (local != null) {
                                  teacherList = local.staffs;
                                  currentPage = local.currentPage;
                                  lastPage = local.lastPage;
                                  setState(() => _loading = false);
                                }
                              }
                            },
                            onPrevious: () async {
                              if (currentPage > 1) {
                                currentPage--;
                                setState(() => _loading = true);
                                final local = await StaffRepo()
                                    .getStaffList(page: currentPage);
                                if (local != null) {
                                  teacherList = local.staffs;
                                  currentPage = local.currentPage;
                                  lastPage = local.lastPage;
                                  setState(() => _loading = false);
                                }
                              }
                            },
                            currentPage: currentPage,
                            lastPage: lastPage,
                          ),
                        ],
                      );
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
