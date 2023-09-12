import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CountDisplay extends StatelessWidget {
  final int students;
  final int staffs;
  final int technicalStudents;
  const CountDisplay({
    super.key,
    required this.staffs,
    required this.students,
    required this.technicalStudents,
  });

  @override
  Widget build(BuildContext context) {
    final wrapper = ResponsiveWrapper.of(context);
    return wrapper.isLargerThan(TABLET)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CountWidget(number: staffs, forWhat: "Staffs"),
              CountWidget(number: students, forWhat: "Students"),
              CountWidget(
                  number: technicalStudents, forWhat: "Technical Students"),
            ],
          )
        : Column(
            children: [
              CountWidget(number: staffs, forWhat: "Staffs"),
              CountWidget(number: students, forWhat: "Students"),
              CountWidget(
                  number: technicalStudents, forWhat: "Technical Students"),
            ],
          );
  }
}

class CountWidget extends StatelessWidget {
  final int number;
  final String forWhat;
  const CountWidget({super.key, required this.number, required this.forWhat});

  @override
  Widget build(BuildContext context) {
    final wrapper = ResponsiveWrapper.of(context);

    return Container(
      height: wrapper.screenHeight * 0.3,
      width: wrapper.screenWidth * 0.30,
      decoration: BoxDecoration(
        color: Colors.blue,
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 32,
            ),
          ),
          SizedBox(height: 8),
          Text(
            forWhat,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
