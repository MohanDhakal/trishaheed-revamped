import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../utilities/images.dart';

class StudentSaying extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);

    final size = MediaQuery.of(context).size;
    return Container(
      width: responsiveWrapper.isSmallerThan(TABLET)
          ? size.width * 0.9
          : size.width * 0.3,
      height: size.height * 0.5,
      decoration: BoxDecoration(
        color: Colors.white70,
        boxShadow: shadow,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SelectableText(
            saying ??
                """Many of our teachers have years of teaching experience which helps our student get some practical knowledge alongside theory.""",
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.8,
            ),
          ),
          SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(48),
            child: Image.asset(
              profile,
              height: 96,
              width: 96,
            ),
          ),
          SizedBox(height: 20),
          SelectableText(
            name ?? "Anonymous",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          SelectableText(
            title ?? "Former Student",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Color.fromARGB(255, 255, 102, 0),
                ),
          ),
        ],
      ),
    );
  }
}
