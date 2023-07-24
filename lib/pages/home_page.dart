import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/widgets/footer.dart';
import '../utilities/button_position.dart';
import '../utilities/images.dart';
import '../widgets/headmaster_saying.dart';
import '../widgets/highlights.dart';
import '../widgets/staff.dart';
import '../model/staff.dart' as s;
import '../widgets/student_saying.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white30,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // ImageSlideshow(
            //   height: 400.0,
            //   children: [
            //     Image.asset(
            //       carousel1,
            //       fit: BoxFit.cover,
            //       // width: double.infinity,
            //     ),
            //     Image.asset(
            //       carousel2,
            //       fit: BoxFit.cover,
            //       // width: double.infinity,
            //     ),
            //     Image.network(
            //       carousel3,
            //       fit: BoxFit.cover,
            //       // width: double.infinity,
            //     ),
            //   ],
            //   initialPage: 0,
            //   indicatorColor: Colors.black87,
            //   autoPlayInterval: 5000,
            //   isLoop: true,
            //   onPageChanged: (value) {
            //     //todo: implement on page changed for carousel
            //   },
            // ),
            SizedBox(height: 24),
            HeadMasterSaying(),
            SizedBox(height: 48),
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
            SizedBox(height: 48),
            ResponsiveRowColumn(
              layout: responsiveWrapper.isSmallerThan(TABLET)
                  ? ResponsiveRowColumnType.COLUMN
                  : ResponsiveRowColumnType.ROW,
              rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
              columnMainAxisAlignment: MainAxisAlignment.center,
              children: [
                ResponsiveRowColumnItem(
                  child: Staff(
                    staff: s.Staff(
                      1,
                      2,
                      "Full Name ",
                      "Secondary",
                      "Java Programming",
                      Position.passive,
                    ),
                  ),
                ),
                ResponsiveRowColumnItem(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Staff(
                      staff: s.Staff(
                        1,
                        2,
                        "Full Name ",
                        "Secondary",
                        "Java Programming",
                        Position.passive,
                      ),
                    ),
                  ),
                ),
                ResponsiveRowColumnItem(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Staff(
                      staff: s.Staff(
                        1,
                        2,
                        "Full Name ",
                        "Secondary",
                        "Java Programming",
                        Position.passive,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 36),
              child: Text(
                "HIGHLIGHTS",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
              ),
            ),
            SizedBox(width: size.width * 0.2, child: Divider(thickness: 4)),
            SizedBox(height: 48),
            responsiveWrapper.isLargerThan(TABLET)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Highlights(
                        imageUri: progressIcon,
                        title: "Experienced Teachers",
                        detail:
                            """Many of our teachers have years of teaching experience which helps our student get some practical knowledge alongside theory.""",
                      ),
                      Highlights(
                        imageUri: microscopeIcon,
                        title: "Lab and Library",
                        detail:
                            """Many of our teachers have years of teaching experience which helps our student get some practical knowledge alongside theory.""",
                        backgroundColor: Colors.black,
                      ),
                      Highlights(
                        imageUri: readingIcon,
                        title: "Technical Education",
                        detail:
                            """Technology is inevitable in today's world.Our schools offers Computer Engineering to students willing to learn and explore more in technology sector.""",
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Highlights(
                        imageUri: readingIcon,
                        title: "Technical Education",
                        detail:
                            """Technology is inevitable in today's world.Our schools offers Computer Engineering to students willing to learn and explore more in technology sector.""",
                      ),
                      SizedBox(height: 10),
                      Highlights(
                        imageUri: microscopeIcon,
                        title: "Lab and Library",
                        detail:
                            """Many of our teachers have years of teaching experience which helps our student get some practical knowledge alongside theory.""",
                        backgroundColor: Colors.black,
                      ),
                      SizedBox(height: 10),
                      Highlights(
                        imageUri: readingIcon,
                        title: "Technical Education",
                        detail:
                            """Technology is inevitable in today's world.Our schools offers Computer Engineering to students willing to learn and explore more in technology sector.""",
                      ),
                    ],
                  ),
            SizedBox(height: 48),
            Center(
              child: Text(
                " STUDENTS SAYING",
                style: responsiveWrapper.isSmallerThan(TABLET)
                    ? Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold)
                    : Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: size.width * 0.2, child: Divider(thickness: 4)),
            SizedBox(height: 12),
            Center(
              child: Text(
                "This is what our students has to say about us",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(height: 48),
            responsiveWrapper.isSmallerThan(DESKTOP)
                ? ResponsiveRowColumn(
                    layout: ResponsiveRowColumnType.ROW,
                    columnMainAxisAlignment: MainAxisAlignment.center,
                    rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ResponsiveRowColumnItem(
                        child: StudentSaying(
                          shadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(1, 1),
                              blurRadius: 1,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                      responsiveWrapper.isSmallerThan(DESKTOP)
                          ? ResponsiveRowColumnItem(
                              child: SizedBox(
                                height: 10,
                                child: Divider(height: 5.0),
                              ),
                            )
                          : ResponsiveRowColumnItem(child: SizedBox()),
                      ResponsiveRowColumnItem(
                          child: StudentSaying(
                        shadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            spreadRadius: 4,
                          ),
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(-2, -2),
                            blurRadius: 4,
                            spreadRadius: 4,
                          )
                        ],
                      )),
                      responsiveWrapper.isSmallerThan(DESKTOP)
                          ? ResponsiveRowColumnItem(
                              child: SizedBox(
                                height: 10,
                                child: Divider(height: 5.0),
                              ),
                            )
                          : ResponsiveRowColumnItem(child: SizedBox()),
                      ResponsiveRowColumnItem(
                          child: StudentSaying(
                        shadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(1, 1),
                            blurRadius: 1,
                            spreadRadius: 1,
                          )
                        ],
                      )),
                    ],
                  )
                : SizedBox(
                    height: size.height * 0.45,
                    child: Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                StudentSaying(
                                  height: size.height * 0.35,
                                  shadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(4, 4),
                                      blurRadius: 4,
                                      spreadRadius: 4,
                                    ),
                                  ],
                                ),
                                StudentSaying(
                                  height: size.height * 0.35,
                                  shadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(4, 4),
                                      blurRadius: 4,
                                      spreadRadius: 4,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: size.width * 0.335,
                            bottom: 2,
                            top: 2,
                            child: Card(
                              elevation: 16,
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Adjust the border radius as needed
                              ),
                              child: StudentSaying(
                                height: size.height * 0.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            SizedBox(height: 48),
            FooterWidget(color: Colors.black12),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
