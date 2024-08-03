import 'dart:math';

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../utilities/images.dart';

class StudentSaying extends StatefulWidget {
  final List<BoxShadow>? shadow;
  final String? saying;
  final String? name;
  final String? title;
  const StudentSaying({
    Key? key,
    this.shadow,
    this.saying,
    this.name,
    this.title,
  }) : super(key: key);

  @override
  State<StudentSaying> createState() => _StudentSayingState();
}

class _StudentSayingState extends State<StudentSaying> {
  double angle = pi;
  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);

    final size = MediaQuery.of(context).size;
    return VisibilityDetector(
      key: Key('student_saying ${widget.name}'),
      onVisibilityChanged: (VisibilityInfo info) {
        var visiblePercentage = info.visibleFraction * 100;
        if (visiblePercentage > 1 && angle == pi) {
          setState(() {
            angle = 0;
          });
        }
      },
      child: AnimatedContainer(
        width: responsiveWrapper.isSmallerThan(TABLET)
            ? size.width * 0.9
            : size.width * 0.3,
        height: size.height * 0.5,
        decoration: BoxDecoration(
          color: Colors.white70,
          boxShadow: widget.shadow,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.all(4),
        duration: Duration(milliseconds: 500),
        transform: Matrix4.identity()..rotateY(angle),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SelectableText(
              widget.saying ??
                  """Many of our teachers have years of teaching experience which helps our student get some practical knowledge alongside theory.""",
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.8,
              ),
            ),
            SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(48),
              child: Image.asset(
                profile,
                height: 96,
                width: 96,
              ),
            ),
            SizedBox(height: 16),
            SelectableText(
              widget.name ?? "Anonymous",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SelectableText(
              widget.title ?? "Former Student",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Color.fromARGB(255, 255, 102, 0),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
