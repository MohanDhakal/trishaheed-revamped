import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:trishaheed/model/student.dart';
import 'package:trishaheed/utilities/images.dart';

class StudentWidget extends StatelessWidget {
  final Student student;
  final StudentContact? studentContact;
  const StudentWidget({
    required this.student,
    Key? key,
    this.studentContact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.purpleAccent,
          width: 4,
        ),
        boxShadow: student.isFocused ?? false
            ? [
                BoxShadow(
                  blurRadius: 8.0,
                  spreadRadius: 8.0,
                  color: Colors.black12,
                )
              ]
            : null,
        gradient: LinearGradient(
          colors: [Color(0xFFEAAECA), Color(0XFF94BBE9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blueAccent,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 8.0,
                  spreadRadius: 8.0,
                  color: Colors.black12,
                )
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.0,
                    spreadRadius: 4.0,
                    color: Colors.grey.shade200,
                  )
                ],
                image: student.imageUri != null
                    ? DecorationImage(
                        image: NetworkImage(
                          student.imageUri!,
                        ),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image: AssetImage(profile),
                        fit: BoxFit.cover,
                      ),
              ),
              width: 150,
              height: 150,
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
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              student.address,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
            child: RichText(
              text: TextSpan(
                text: '${student.majorSubject}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 8)
        ],
      ),
    );
  }
}
