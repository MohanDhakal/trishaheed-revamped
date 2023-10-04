import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/widgets/count_display.dart';
import 'package:trishaheed/widgets/footer.dart';
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
  final FocusNode _focusNode = FocusNode();
  final ScrollController _controller = ScrollController();
  final CarouselController _carouselController = CarouselController();
  List<Widget> _images = [];
  // int _selectedImage = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      setState(() {
        _images = List.generate(
          carouselImages.length,
          (index) {
            return Image.asset(
              carouselImages[index],
              fit: BoxFit.cover,
            );
          },
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white30,
      child: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: responsiveWrapper.isSmallerThan(TABLET) ? null : _handleKeyEvent,
        autofocus: true,
        child: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              Stack(
                children: [
                  CarouselSlider(
                    items: _images,
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      initialPage: 1,
                      autoPlayInterval: Duration(milliseconds: 1000),
                      reverse: true,
                      aspectRatio: responsiveWrapper.isSmallerThan(DESKTOP)
                          ? 4 / 3
                          : 16 / 9,
                      viewportFraction: 1,
                      pageSnapping: true,
                      onPageChanged: (index, reason) {},
                    ),
                  ),
                  Positioned(
                    top: responsiveWrapper.isMobile
                        ? size.height * 0.25
                        : size.height * 0.4,
                    left: 20,
                    child: MaterialButton(
                      onPressed: () {
                        _carouselController.nextPage();
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Icon(
                          Icons.navigate_before,
                          size: 30,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: responsiveWrapper.isMobile
                        ? size.height * 0.25
                        : size.height * 0.4,
                    right: 20,
                    child: MaterialButton(
                      onPressed: () {
                        _carouselController.previousPage();
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Icon(
                          Icons.navigate_next,
                          size: 30,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 24),
              Text(
                'प्रधानाध्यापक को कलमबाट',
                textAlign: TextAlign.center,
                style: ResponsiveWrapper.of(context).isMobile
                    ? Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold)
                    : Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: size.width * 0.2, child: Divider(thickness: 4)),
              SizedBox(height: 24),
              HeadMasterSaying(),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Staff and Students",
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
              CountDisplay(
                staffs: 33,
                students: 487,
                technicalStudents: 50,
              ),
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
                layout: responsiveWrapper.isSmallerThan(DESKTOP)
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
                columnMainAxisAlignment: MainAxisAlignment.center,
                columnMainAxisSize: MainAxisSize.min,
                children: [
                  ResponsiveRowColumnItem(
                    child: Staff(
                      staff: s.Staff(
                        fullName: "Jay Prasad Chapagain",
                        post: "Head Teacher",
                        dob: "2080-03-25",
                        address: "Arjunchapari-4, Syangja",
                        isActive: 1,
                        joinedAt: "2080-03-25",
                        majorSubject: "HPE",
                        jobType: "Permanent",
                        rank: "0.1",
                        teacherLevel: "Primary",
                        imageUrl: contact1,
                        contact: "9856053186",
                      ),
                      static: true,
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Staff(
                        staff: s.Staff(
                          fullName: "Teknath Khanal",
                          post: "Asst.Head Teacher",
                          dob: "2080-03-25",
                          address: "Arjunchapari-4, Syangja",
                          isActive: 1,
                          joinedAt: "2080-03-25",
                          majorSubject: "English",
                          jobType: "Permanent",
                          rank: "0.1",
                          teacherLevel: "Secondary Level 2",
                          imageUrl: contact2,
                          contact: "9846095574",
                        ),
                        static: true,
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Staff(
                        staff: s.Staff(
                          fullName: "Mohan Kumar Dhakal",
                          post: "Technical Co-Ordinator",
                          dob: "2080-03-25",
                          address: "Panchamool-1, SYangja",
                          isActive: 1,
                          joinedAt: "2080-03-25",
                          majorSubject: "BE.Software",
                          jobType: "Temporary",
                          rank: "0.1",
                          teacherLevel: "Secondary Level 2",
                          contact: "9862790724",
                        ),
                        static: true,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 36),
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
                              """Organized and Managed Practical Laboratory and well equipped library are of the major highlights of our school where experts lead you to be productive and practical.""",
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Highlights(
                          imageUri: progressIcon,
                          title: "Experienced Teachers",
                          detail:
                              """Many of our teachers have years of teaching experience which helps our student get some practical knowledge alongside theory.""",
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
                  " STUDENT TESTIMONIALS",
                  textAlign: TextAlign.center,
                  style: responsiveWrapper.isSmallerThan(DESKTOP)
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
                      layout: responsiveWrapper.isSmallerThan(DESKTOP)
                          ? ResponsiveRowColumnType.COLUMN
                          : ResponsiveRowColumnType.ROW,
                      columnMainAxisAlignment: MainAxisAlignment.center,
                      rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ResponsiveRowColumnItem(
                          child: StudentSaying(
                            saying:
                                """Friendly and motivating environment really helps us focus on what really matters. Our Teachers are available whenever we need them to clarify doubts.""",
                            name: "Samraj Darji",
                            title: "Student",
                            shadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(4, 4),
                                blurRadius: 4,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                        ),
                        ResponsiveRowColumnItem(
                          child: StudentSaying(
                            saying:
                                "'Technology is inevitable in today's world.I have been involved in Technical Stream from Grade 9, which has helped me grow as a technical person.'",
                            name: "Milan Dhakal",
                            title: "Student",
                            shadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(4, 4),
                                blurRadius: 4,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                        ),
                        ResponsiveRowColumnItem(
                          child: StudentSaying(
                            saying:
                                """ I joined Tri-Shaheed at grade 5, The environment for study has improved as the time passes by. Today, while working as an instructor, I feel quality of our student has improved alot.""",
                            name: "Mohan k. Dhakal",
                            title: "Technical Instructor(Former Student)",
                            shadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(4, 4),
                                blurRadius: 4,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StudentSaying(
                            saying:
                                """Friendly and motivating environment really helps us focus on what really matters. Our Teachers are available whenever we need them to clarify doubts.""",
                            name: "Samraj Darji",
                            title: "Student",
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
                            name: "Milan Dhakal",
                            title: "Student",
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
                            saying:
                                """ I joined Tri-Shaheed at grade 5, The environment for study has improved as the time passes by. Today, while working as an instructor, I feel quality of our student has improved alot.""",
                            name: "Mohan k. Dhakal",
                            title: "Technical Instructor",
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
              SizedBox(height: 48),
              FooterWidget(color: Colors.black12),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    var offset = _controller.offset;
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        if (kReleaseMode) {
          _controller.animateTo(offset - 50,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        } else {
          _controller.animateTo(offset - 50,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        }
      });
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        if (kReleaseMode) {
          _controller.animateTo(offset + 50,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        } else {
          _controller.animateTo(offset + 50,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        }
      });
    }
  }
}
