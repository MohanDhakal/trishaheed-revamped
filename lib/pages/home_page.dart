import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/model/states/staff_state.dart';
import 'package:trishaheed/widgets/count_display.dart';
import 'package:trishaheed/widgets/events_section.dart';
import 'package:trishaheed/widgets/footer.dart';
import 'package:trishaheed/widgets/major_contacts.dart';
import 'package:trishaheed/widgets/testimonials.dart';
import '../utilities/images.dart';
import '../widgets/headmaster_saying.dart';
import '../widgets/highlights.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode _focusNode = FocusNode();
  final ScrollController _controller = ScrollController();
  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300)).then((value) {
      Provider.of<StaffState>(context, listen: false).contacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white30,
      child: KeyboardListener(
        focusNode: _focusNode,
        onKeyEvent:
            responsiveWrapper.isSmallerThan(TABLET) ? null : _handleKeyEvent,
        autofocus: true,
        child: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.7,
                width: size.width,
                child: CarouselView(
                  itemExtent: size.width,
                  scrollDirection: Axis.horizontal,
                  controller: _carouselController,
                  padding: EdgeInsets.all(0),
                  itemSnapping: true,
                  shape: ContinuousRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  children: [
                    ...List.generate(
                      carouselImages.length,
                      (index) {
                        return Image.network(
                          carouselImages[index],
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              // Image has been fully loaded, return the child image
                              return child;
                            }
                            // While loading, return a circular progress indicator
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Loading...',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                ],
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            print(exception.toString());
                            return Center(child: Text('Image failed to load'));
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 8),
              HeadMasterSaying(),
              SizedBox(height: 16),
              MajorContacts(),
              SizedBox(height: 16),
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
              // NumberCounter(),
              CountDisplay(
                staffs: 33,
                students: 487,
                technicalStudents: 50,
              ),
              SizedBox(height: 16),
              EventSection(),
              SizedBox(height: 16),
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
              SizedBox(height: 16),
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
              SizedBox(height: 16),
              Center(
                child: Text(
                  " STUDENT TESTIMONIALS",
                  textAlign: TextAlign.center,
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
              Center(
                child: Text(
                  "This is what our students has to say about us",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              Testimonials(),
              SizedBox(height: 24),
              kIsWeb ? FooterWidget(color: Colors.black12) : SizedBox(),
              // SizedBox(height: 12),
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

  void _handleKeyEvent(KeyEvent event) {
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
