// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../model/student.dart';
import '../utilities/images.dart';

class StudentDetail extends StatefulWidget {
  final Student student;
  final StudentContact? stdContact;
  Function() onBackPressed;
  StudentDetail({
    Key? key,
    required this.student,
    required this.onBackPressed,
    this.stdContact,
    value,
  }) : super(key: key);

  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween(begin: -50.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
    Future.delayed(Duration.zero).then((value) => _controller.forward());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: widget.onBackPressed,
                iconSize: 24,
              ),
              SizedBox(width: 12),
              Text(
                widget.student.fullName,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 24),
          AnimatedBuilder(
              animation: _animation,
              builder: (context, value) {
                final position = _animation.value;
                final transform = Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(
                    position,
                  );
                return Transform(
                  transform: transform,
                  alignment: Alignment.centerLeft,
                  child: ResponsiveRowColumn(
                    layout: responsiveWrapper.isSmallerThan(TABLET)
                        ? ResponsiveRowColumnType.COLUMN
                        : ResponsiveRowColumnType.ROW,
                    rowMainAxisAlignment: MainAxisAlignment.center,
                    rowCrossAxisAlignment: CrossAxisAlignment.center,
                    columnCrossAxisAlignment: CrossAxisAlignment.center,
                    columnMainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ResponsiveRowColumnItem(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
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
                                image: widget.student.imageUri != null
                                    ? DecorationImage(
                                        image: NetworkImage(
                                          widget.student.imageUri!,
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: AssetImage(profile),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              width: 300,
                              height: 360,
                            ),
                            SizedBox(height: 24),
                            Text(
                              widget.student.fullName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      responsiveWrapper.isSmallerThan(TABLET)
                          ? ResponsiveRowColumnItem(child: SizedBox(height: 24))
                          : ResponsiveRowColumnItem(child: SizedBox(width: 48)),
                      ResponsiveRowColumnItem(
                        child: SizedBox(
                          width: responsiveWrapper.isSmallerThan(TABLET)
                              ? size.width
                              : size.width * 0.35,
                          child: Center(
                            child: Card(
                              elevation: 8,
                              color: Colors.grey.shade100,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 24,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Center(
                                      child: RichText(
                                        text: TextSpan(
                                          text: "Detailed Information" + "  ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                        ),
                                      ),
                                    ),
                                    Divider(thickness: 4),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: "Major :" + "  ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          children: [
                                            TextSpan(
                                              text: widget.student.majorSubject,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: "POSITION :" + "  ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          children: [
                                            TextSpan(
                                              text: widget.student.currentRank
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: "Roll Number :" + "  ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          children: [
                                            TextSpan(
                                              text: widget.student.rollNumber
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: "Date Of Birth: " + "  ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          children: [
                                            TextSpan(
                                              text: widget.student.dob,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: "Jonined At: " + "  ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          children: [
                                            TextSpan(
                                              text: widget.student.joinedAt,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: "Contact Number :" + "  ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          children: [
                                            TextSpan(
                                              text: widget
                                                  .stdContact?.phoneNumber
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: "Guardian Contact Number :" +
                                              "  ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          children: [
                                            TextSpan(
                                              text: widget
                                                  .stdContact?.guardianContact
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: "Email Address :" + "  ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          children: [
                                            TextSpan(
                                              text: widget.stdContact?.email
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
