import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../model/student.dart';
import '../utilities/images.dart';

// ignore: must_be_immutable
class StudentDetail extends StatelessWidget {
  final Student student;
  Function() onBackPressed;
  StudentDetail({
    Key? key,
    required this.student,
    required this.onBackPressed,
    value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // SizedBox(width: 12),
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: onBackPressed,
                  iconSize: 36,
                ),
                SizedBox(width: 12),
                Text(
                  student.fullName,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 24),
            ResponsiveRowColumn(
              layout: responsiveWrapper.isSmallerThan(DESKTOP)
                  ? ResponsiveRowColumnType.COLUMN
                  : ResponsiveRowColumnType.ROW,
              rowMainAxisAlignment: MainAxisAlignment.center,
              rowCrossAxisAlignment: CrossAxisAlignment.center,
              columnCrossAxisAlignment: CrossAxisAlignment.start,
              columnMainAxisAlignment: MainAxisAlignment.start,
              children: [
                ResponsiveRowColumnItem(
                  child: ResponsiveRowColumn(
                    layout: responsiveWrapper.isSmallerThan(DESKTOP)
                        ? ResponsiveRowColumnType.COLUMN
                        : ResponsiveRowColumnType.ROW,
                    rowMainAxisAlignment: MainAxisAlignment.center,
                    rowCrossAxisAlignment: CrossAxisAlignment.center,
                    columnCrossAxisAlignment: CrossAxisAlignment.center,
                    columnMainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ResponsiveRowColumnItem(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          child: student.image_url == null
                              ? Image.asset(
                                  profile,
                                  fit: BoxFit.contain,
                                  width:
                                      responsiveWrapper.isSmallerThan(DESKTOP)
                                          ? size.width * 0.9
                                          : size.width * 0.3,
                                  height: size.height * 0.4,
                                )
                              : Image.network(
                                  student.image_url!,
                                  fit: BoxFit.contain,
                                  height: size.height * 0.5,
                                  width:
                                      responsiveWrapper.isSmallerThan(DESKTOP)
                                          ? size.width * 0.9
                                          : size.width * 0.3,
                                ),
                        ),
                      ),
                      responsiveWrapper.isSmallerThan(DESKTOP)
                          ? ResponsiveRowColumnItem(child: SizedBox(height: 24))
                          : ResponsiveRowColumnItem(child: SizedBox(width: 48)),
                      ResponsiveRowColumnItem(
                        child: SizedBox(
                          width: responsiveWrapper.isSmallerThan(DESKTOP)
                              ? size.width * 0.90
                              : size.width * 0.35,
                          child: Card(
                            elevation: 8,
                            color: Colors.blue.shade400,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 24,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      student.fullName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "SUBJECT :" + "  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: student.majorSubject,
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
                                            text:
                                                student.currentRank.toString(),
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
                                            text: student.rollNumber.toString(),
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
                                            text: student.dob,
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
                                            text: student.joinedAt,
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
                                        text:
                                            "Guardian Contact Number :" + "  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: student.guardianContact ??
                                                "९८७६******",
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
                                            text: student.email ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
