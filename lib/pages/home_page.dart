import 'package:flutter/material.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: [
          // ImageSlideshow(
          //   height: 400,
          //   children: [
          //     Image.asset(
          //       carousel1,
          //       fit: BoxFit.fitWidth,
          //       // width: double.infinity,
          //     ),
          //     Image.asset(
          //       carousel2,
          //       fit: BoxFit.fitWidth,

          //       // width: double.infinity,
          //     ),
          //     Image.network(
          //       carousel3,
          //       fit: BoxFit.fitWidth,
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
          SizedBox(
            height: 20,
          ),
          HeadMasterSaying(),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Major Contacts",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
            ),
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Staff(
                staff: s.Staff(
                  1,
                  2,
                  "Full Name ",
                  "Secondary",
                  "Java Programming",
                  Position.passive,
                ),
              ),
              Staff(
                staff: s.Staff(
                  1,
                  2,
                  "Full Name ",
                  "Secondary",
                  "Java Programming",
                  Position.passive,
                ),
              ),
              Staff(
                staff: s.Staff(
                  1,
                  2,
                  "Full Name ",
                  "Secondary",
                  "Java Programming",
                  Position.passive,
                ),
              ),
            ],
          ),
          SizedBox(height: 50),
          Row(
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
              Highlights(
                imageUri: microscopeIcon,
                title: "Lab and Library",
                detail:
                    """Many of our teachers have years of teaching experience which helps our student get some practical knowledge alongside theory.""",
                backgroundColor: Colors.black,
              ),
            ],
          ),
          SizedBox(height: 50),
          Center(
            child: Text(
              " STUDENTS SAYING",
              style: Theme.of(context).textTheme.headline3?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "This is what our students has to say about us",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StudentSaying(),
              StudentSaying(),
              StudentSaying(),
            ],
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}