import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:trishaheed/model/testimonial.dart';
import 'package:trishaheed/repository/testimonial_repo.dart';
import 'student_saying.dart';

class Testimonials extends StatefulWidget {
  const Testimonials({super.key});

  @override
  State<Testimonials> createState() => _TestimonialsState();
}

class _TestimonialsState extends State<Testimonials> {
  List<Testimonial> testimonials = [];

  @override
  void initState() {
    TestimonialRepo().testimonials().then((List<Testimonial> value) {
      if (value.isNotEmpty) {
        if (value.length > 3) {
          setState(() {
            testimonials = value.sublist(0, 3);
          });
        } else {
          setState(() {
            testimonials = value;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    return responsiveWrapper.isSmallerThan(TABLET)
        ? ResponsiveRowColumn(
            layout: responsiveWrapper.isSmallerThan(TABLET)
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
            columnMainAxisAlignment: MainAxisAlignment.center,
            rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...List.generate(testimonials.length, (index) {
                return ResponsiveRowColumnItem(
                  child: StudentSaying(
                    saying: """${testimonials.elementAt(index).message}""",
                    name: "${testimonials.elementAt(index).fullName}",
                    title: "${testimonials.elementAt(index).currentStatus}",
                    shadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(4, 4),
                        blurRadius: 4,
                        spreadRadius: 4,
                      ),
                    ],
                    id: testimonials.elementAt(index).id,
                  ),
                );
              }),
            ],
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(testimonials.length, (index) {
                  return ResponsiveRowColumnItem(
                    child: StudentSaying(
                      saying: """ ${testimonials.elementAt(index).message}""",
                      name: "${testimonials.elementAt(index).fullName}",
                      title: "${testimonials.elementAt(index).currentStatus}",
                      imageUri: testimonials.elementAt(index).imageUri,
                      id: testimonials.elementAt(index).id,
                      shadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(4, 4),
                          blurRadius: 4,
                          spreadRadius: 4,
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
