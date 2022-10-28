import 'package:flutter/material.dart';
import 'package:trishaheed/model/staff.dart' as s;
import 'package:trishaheed/utilities/button_position.dart';
import 'package:trishaheed/utilities/images.dart';

class Staff extends StatelessWidget {
  final s.Staff staff;
  const Staff({
    Key? key,
    required this.staff,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: staff.position == Position.passive ? Colors.red : Colors.blue,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            potraitSample,
            // fit: BoxFit.cover,
            fit: BoxFit.fill,
            // color: Colors.black,
            width: 300,
            height: 200,
            // height: double.infinity / 2,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            staff.fullName,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  // color: Colors.white,
                  fontSize: 18,
                ),
          ),
          Text(
            staff.majorSubject,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  // color: Colors.white,
                  height: 1.5,
                  fontSize: 16,
                ),
          ),
          Text(
            "Sikshak Shreni",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  // color: Colors.white,
                  height: 1.5,
                  fontSize: 16,
                ),
          ),
          Text(
            staff.contact ?? "Not Available",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  // color: Colors.white,
                  // height: 1.5,
                  fontSize: 14,
                ),
          ),
        ],
      ),
    );
  }
}
