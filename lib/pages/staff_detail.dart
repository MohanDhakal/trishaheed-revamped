import 'package:flutter/material.dart';
import 'package:trishaheed/model/staff.dart';
import 'package:trishaheed/widgets/staff.dart' as s;

class StaffDetail extends StatelessWidget {
  final Staff model;
  const StaffDetail({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: s.Staff(staff: model),
        alignment: Alignment.center,
      ),
    );
  }
}
