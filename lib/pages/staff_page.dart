import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trishaheed/model/staff.dart' as s;
import 'package:trishaheed/repository/staff_repo.dart';
import 'package:trishaheed/widgets/staff.dart';
import '../utilities/menu_tag.dart';

class TeacherStaff extends StatefulWidget {
  final Function(MenuTag m, s.Staff teacherStaff, int staffId) onClick;
  const TeacherStaff({Key? key, required this.onClick}) : super(key: key);

  @override
  State<TeacherStaff> createState() => _TeacherStaffState();
}

class _TeacherStaffState extends State<TeacherStaff> {
  List<s.Staff> teacherList = [];
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
    return _loading
        ? Material(
            child: Shimmer.fromColors(
              baseColor: Colors.blueGrey.shade300,
              highlightColor: Colors.blueGrey.shade100,
              enabled: true,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: responsiveWrapper.isLargerThan(TABLET)
                    ? Padding(
                      padding: const EdgeInsets.only(top:24.0),
                      child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 16.0),
                                BannerPlaceholder(),
                                TitlePlaceholder(),
                                SizedBox(height: 16.0),
                              ],
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 16.0),
                                BannerPlaceholder(),
                                TitlePlaceholder(),
                                SizedBox(height: 16.0),
                              ],
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 16.0),
                                BannerPlaceholder(),
                                TitlePlaceholder(),
                                SizedBox(height: 16.0),
                              ],
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 16.0),
                                BannerPlaceholder(),
                                TitlePlaceholder(),
                                SizedBox(height: 16.0),
                              ],
                            ),
                          ],
                        ),
                    )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 8.0),
                          BannerPlaceholder(),
                          TitlePlaceholder(),
                          SizedBox(height: 8.0),
                          BannerPlaceholder(),
                          TitlePlaceholder(),
                        ],
                      ),
              ),
            ),
          )
        : (teacherList.isEmpty)
            ? SizedBox(
                child: Center(
                  child: Text("Could not find teacher list"),
                ),
              )
            : responsiveWrapper.isLargerThan(TABLET)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 36),
                      GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: 8.0),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.8,
                          maxCrossAxisExtent:
                              responsiveWrapper.isSmallerThan(TABLET)
                                  ? size.width * 0.9
                                  : size.width * 0.3,
                        ),
                        itemCount: teacherList.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: (() {
                              s.Staff selectedStaff =
                                  teacherList.elementAt(index);
                              widget.onClick(MenuTag.staffDetail, selectedStaff,
                                  selectedStaff.id!);
                            }),
                            onHover: ((value) {
                              setState(() {
                                teacherList[index].onFocused = value;
                              });
                            }),
                            child: Staff(
                              staff: teacherList[index],
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 24),
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
                      Expanded(
                        child: ListView.builder(
                          itemCount: teacherList.length,
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: (() {
                                s.Staff selectedStaff =
                                    teacherList.elementAt(index);
                                widget.onClick(MenuTag.staffDetail,
                                    selectedStaff, selectedStaff.id!);
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
                                child: SizedBox(
                                  width: size.width * 0.7,
                                  height: size.height*0.6,
                                  child: Staff(
                                    staff: teacherList[index],
                                    // width: MediaQuery.of(context).size.width,
                                  ),
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

class TitlePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 12.0,
          ),
          child: Text(
            "Loading.......",
            // overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 12.0,
          ),
          child: Text(
            "Loading........",
            // overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 12.0,
          ),
          child: Text(
            "Loading........",
            // overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}

class BannerPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    final size = MediaQuery.of(context).size;
    return Container(
      width: responsiveWrapper.isSmallerThan(DESKTOP)
          ? size.width * 0.8
          : size.width * 0.2,
      height: size.height * 0.4,
      color: Colors.green,
    );
  }
}
