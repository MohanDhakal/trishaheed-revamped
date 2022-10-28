import 'package:flutter/material.dart';
import 'package:trishaheed/model/staff.dart' as s;
import 'package:trishaheed/repository/staff_info.dart';
import 'package:trishaheed/utilities/button_position.dart';
import 'package:trishaheed/utilities/route_names.dart';
import 'package:trishaheed/widgets/staff.dart';

class TeacherStaff extends StatefulWidget {
  const TeacherStaff({Key? key}) : super(key: key);

  @override
  State<TeacherStaff> createState() => _TeacherStaffState();
}

class _TeacherStaffState extends State<TeacherStaff> {
  List<s.Staff> teacherList = [];
  int? detailForId;
  @override
  void initState() {
    StaffApi().getStaffList().then((value) {
      setState(() {
        teacherList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (teacherList.isEmpty)
        ? SizedBox(
            child: Center(
              child: Text("Could not find teacher list"),
            ),
          )
        : GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemCount: teacherList.length,
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: (() {
                  Navigator.pushNamed(context, RouteName.staffDetail,
                      arguments: teacherList[index]);
                }),
                onHover: ((value) {
                  setState(() {
                    if (teacherList[index].position == Position.passive) {
                      teacherList[index].position = Position.hovered;
                      // print("reached at 1");
                    } else {
                      teacherList[index].position = Position.passive;
                      // print("reached at 2");
                    }
                  });
                }),
                child: Staff(
                  staff: teacherList[index],
                ),
              );
            }),
          );
  }
}