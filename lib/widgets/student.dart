import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:trishaheed/model/student.dart';
import 'package:trishaheed/utilities/images.dart';

class StudentWidget extends StatelessWidget {
  final Student student;
  final StudentContact? studentContact;
  const StudentWidget({
    required this.student,
    Key? key,  this.studentContact,
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
          ? size.width
          : size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: student.imageUri == null
                ? Image.asset(
                    profile,
                    fit: BoxFit.cover,
                    width: responsiveWrapper.isSmallerThan(DESKTOP)
                        ? size.width
                        : size.width * 0.3,
                    height: size.height * 0.3,
                  )
                : Image.network(
                    student.imageUri!,
                    fit: BoxFit.cover,
                    height: size.height * 0.3,
                    width: responsiveWrapper.isSmallerThan(DESKTOP)
                        ? size.width
                        : size.width * 0.3,
                  ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              student.fullName,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: RichText(
              text: TextSpan(
                text: "Roll Number :" + "  ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: RichText(
              text: TextSpan(
                text: "Address: " + "  ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                children: [
                  TextSpan(
                    text: student.address.toString(),
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
                text: "Major In: " + "  ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                children: [
                  TextSpan(
                    text: student.majorSubject.toString() ,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 8)
        ],
      ),
    );
  }
}
