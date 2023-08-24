import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../utilities/images.dart';

class StudentSaying extends StatelessWidget {
  final List<BoxShadow>? shadow;
  final double? width;
  final double? height;
  final String? saying;
  final String? name;
  final String? title;
  const StudentSaying({
    Key? key,
    this.shadow,
    this.width,
    this.height,
    this.saying,
    this.name,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white70,
        boxShadow: shadow,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(4),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              profile,
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                    ? size.width * 0.7
                    : size.width * 0.25,
                child: SelectableText(
                  saying ??
                      """Many of our teachers have years of teaching experience which helps our student get some practical knowledge alongside theory.""",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.8,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SelectableText(
                name ?? "Anonymous",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              SelectableText(
                title ?? "Former Student",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Color.fromARGB(255, 255, 102, 0),
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
