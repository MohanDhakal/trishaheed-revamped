import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/model/staff.dart' as s;
import 'package:trishaheed/utilities/button_position.dart';
import 'package:trishaheed/utilities/images.dart';

class Staff extends StatelessWidget {
  final s.Staff staff;
  final double? width;
  final double? height;
  const Staff({
    Key? key,
    required this.staff,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: staff.position == Position.passive
            ? Colors.grey.shade300
            : Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      width: (width != null) ? width! * 0.6 : null,
      height: (width != null) ? width! : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Image.asset(
              potraitSample,
              fit: BoxFit.fill,
              width: width ?? 300,
              height: 250,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              staff.fullName,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: RichText(
              text: TextSpan(
                text: "विषय :" + "  ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                children: [
                  TextSpan(
                    text: staff.majorSubject,
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
            padding: const EdgeInsets.only(left: 8.0),
            child: RichText(
              text: TextSpan(
                text: "तह :" + "  ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                children: [
                  TextSpan(
                    text: staff.teacherLevel,
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
            padding: const EdgeInsets.only(left: 8.0),
            child: RichText(
              text: TextSpan(
                text: "सम्पर्क‌‌‌‌‌‌ :" + "  ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                children: [
                  TextSpan(
                    text: staff.contact ?? "९८७६५४५६७८",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
