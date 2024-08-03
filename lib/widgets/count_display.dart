import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CountDisplay extends StatefulWidget {
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
  State<CountDisplay> createState() => _CountDisplayState();
}

class _CountDisplayState extends State<CountDisplay> {
  @override
  Widget build(BuildContext context) {
    final wrapper = ResponsiveWrapper.of(context);
    return wrapper.isLargerThan(MOBILE)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CountWidget(number: widget.staffs, forWhat: "Staffs"),
              CountWidget(number: widget.students, forWhat: "Students"),
              CountWidget(
                  number: widget.technicalStudents,
                  forWhat: "Technical Students")
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CountWidget(
                number: widget.staffs,
                forWhat: "Staffs",
              ),
              SizedBox(height: 8),
              CountWidget(
                number: widget.students,
                forWhat: "Students",
              ),
              SizedBox(height: 8),
              CountWidget(
                number: widget.technicalStudents,
                forWhat: "Technical Students",
              ),
              SizedBox(height: 8),
            ],
          );
  }
}

class CountWidget extends StatefulWidget {
  final int number;
  final String forWhat;
  const CountWidget({
    super.key,
    required this.number,
    required this.forWhat,
  });

  @override
  State<CountWidget> createState() => _CountWidgetState();
}

class _CountWidgetState extends State<CountWidget> {
  int _currentNumber = 0;

  void _startCounting() {
    for (int i = 1; i < widget.number; i++) {
      Future.delayed(Duration(milliseconds: 200))
          .then((value) => setState(() => _currentNumber = i));
    }
  }

  @override
  Widget build(BuildContext context) {
    final wrapper = ResponsiveWrapper.of(context);
    return VisibilityDetector(
      key: Key('count_display ${widget.forWhat}'),
      onVisibilityChanged: (VisibilityInfo info) {
        var visiblePercentage = info.visibleFraction * 100;
        if (visiblePercentage > 10 && _currentNumber < 1) _startCounting();
      },
      child: Container(
        height: wrapper.isLargerThan(MOBILE)
            ? wrapper.screenWidth * 0.15
            : wrapper.screenWidth * 0.4,
        width: wrapper.isLargerThan(MOBILE)
            ? wrapper.screenWidth * 0.3
            : wrapper.screenWidth * 0.4,
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
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              // transitionBuilder: (Widget child, Animation<double> animation) {
              //   return FadeTransition(child: child, opacity: animation);
              // },
              child: Text(
                _currentNumber.toString(),
                key: ValueKey<int>(_currentNumber),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.forWhat,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
