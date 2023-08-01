import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:trishaheed/model/staff.dart' as s;
import 'package:trishaheed/utilities/images.dart';

class Staff extends StatelessWidget {
  final s.Staff staff;
  const Staff({
    required this.staff,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      width: responsiveWrapper.isSmallerThan(DESKTOP)
          ? size.width * 0.9
          : size.width * 0.3,
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
            child: Image.network(
              staff.imageUrl ??
                  "https://fastly.picsum.photos/id/185/200/300.jpg?blur=5&hmac=yQe4ekSkmZmozebKHSoPPJ9UjQtZ7Xcu7QLdp56CChw",
              fit: BoxFit.fill,
              width: responsiveWrapper.isSmallerThan(DESKTOP)
                  ? size.width * 0.9
                  : size.width * 0.3,
              height: size.height * 0.3,
            ),
          ),
          SizedBox(height: 36),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              staff.fullName,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: RichText(
              text: TextSpan(
                text: "SUBJECT :" + "  ",
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
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: RichText(
              text: TextSpan(
                text: "POSITION :" + "  ",
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
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: RichText(
              text: TextSpan(
                text: "CONTACT :" + "  ",
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
        ],
      ),
    );
  }
}
