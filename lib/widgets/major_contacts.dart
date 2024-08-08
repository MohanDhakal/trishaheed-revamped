import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../model/states/staff_state.dart';
import '../widgets/staff.dart';
import '../model/staff.dart' as s;

class MajorContacts extends StatefulWidget {
  const MajorContacts({super.key});

  @override
  State<MajorContacts> createState() => _MajorContactsState();
}

class _MajorContactsState extends State<MajorContacts> {
  double endX = 0;
  double endY = 100;

  @override
  void initState() {
    super.initState();
    Provider.of<StaffState>(context, listen: false).contacts();
  }

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    final size = MediaQuery.of(context).size;

    return VisibilityDetector(
      key: Key('major_contacts'),
      onVisibilityChanged: (VisibilityInfo info) {
        var visiblePercentage = info.visibleFraction * 100;
        if (visiblePercentage > 10) {
          if (endY != 0) setState(() => endY = 0);
          // debugPrint('Widget ${info.key} is ${visiblePercentage}% visible');
        }
      },
      child: TweenAnimationBuilder(
          tween: Tween<Offset>(begin: Offset(0, 100), end: Offset(endX, endY)),
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Major Contacts",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        fontStyle: FontStyle.normal,
                      ),
                ),
              ),
              SizedBox(width: size.width * 0.2, child: Divider(thickness: 4)),
              SizedBox(height: 24),
            ],
          ),
          builder: (context, Offset value, child) {
            return Transform.translate(
              offset: value,
              child: Column(
                children: [
                  child ?? SizedBox(),
                  Consumer<StaffState>(builder: (context, model, child) {
                    return ResponsiveRowColumn(
                      layout: responsiveWrapper.isSmallerThan(TABLET)
                          ? ResponsiveRowColumnType.COLUMN
                          : ResponsiveRowColumnType.ROW,
                      rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      columnMainAxisAlignment: MainAxisAlignment.center,
                      columnMainAxisSize: MainAxisSize.min,
                      columnSpacing: 8,
                      children: [
                        ...model.staffs.map((e) {
                          final staff = e.teacherStaff;
                          return staff == null
                              ? ResponsiveRowColumnItem(child: SizedBox())
                              : ResponsiveRowColumnItem(
                                  child: SizedBox(
                                    width:
                                        responsiveWrapper.isSmallerThan(TABLET)
                                            ? size.width *0.8
                                            : size.width * 0.3,
                                    child: Staff(
                                      isStatic: true,
                                      staff: s.Staff(
                                        fullName: staff.fullName,
                                        post: staff.post,
                                        dob: staff.dob,
                                        address: staff.address,
                                        isActive: staff.isActive,
                                        joinedAt: staff.joinedAt,
                                        majorSubject: staff.majorSubject,
                                        jobType: staff.jobType,
                                        rank: staff.rank,
                                        teacherLevel: staff.teacherLevel,
                                        imageUrl: staff.imageUrl,
                                        contact: staff.contact,
                                      ),
                                    ),
                                  ),
                                );
                        }).toList()

                      ],
                    );
                  }),
                ],
              ),
            );
          }),
    );
  }
}
