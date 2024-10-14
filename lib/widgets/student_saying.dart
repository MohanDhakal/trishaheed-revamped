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
  final String? imageUri;
  final int id;
  const StudentSaying({
    Key? key,
    this.shadow,
    this.saying,
    this.name,
    this.title,
    this.imageUri,
    required this.id,
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
      key: Key('student_saying ${widget.id}'),
      onVisibilityChanged: (VisibilityInfo info) {
        var visiblePercentage = info.visibleFraction * 100;
        if (visiblePercentage > 0.5 && angle == pi) {
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
        duration: Duration(milliseconds: 200),
        transform: Matrix4.identity()..rotateY(angle),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                   Positioned(
                  top: 0,
                  left: 96,
                  child: Image.asset(
                    quote,
                    width: 48,
                    height: 48,
                  ),
                ),
                Container(
                  height: 96,
                  width: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blue,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4.0,
                        spreadRadius: 4.0,
                        color: Colors.grey.shade200,
                      )
                    ],
                    image: widget.imageUri != null
                        ? DecorationImage(
                            image: NetworkImage(
                              widget.imageUri!,
                            ),
                            fit: BoxFit.cover,
                          )
                        : DecorationImage(
                            image: AssetImage(profile),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
             
              ],
            ),
            SizedBox(height: 8),
            SelectableText(
              widget.name ?? "Anonymous",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SelectableText(
              widget.title ?? "Not Availahble",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Color.fromARGB(255, 255, 102, 0),
                  ),
            ),
            Expanded(
              child: SizedBox(
                height: size.height * 0.2,
                child: SelectableText(
                  widget.saying ??
                      """Many of our teachers have years of teaching experience which helps our student get some practical knowledge alongside theory.""",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    height: 1.8,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
