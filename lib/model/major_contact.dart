// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:trishaheed/model/staff.dart';
class MajorContact {
  int? id;
  int staffId;
  int position;
  Staff? teacherStaff;
  MajorContact({
    this.id,
    required this.staffId,
    required this.position,
    this.teacherStaff,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'staff_id': staffId,
      'position': position,
    };
  }

  factory MajorContact.fromMap(Map<String, dynamic> map) {
    return MajorContact(
      id: map['id'] != null ? map['id'] as int : null,
      staffId: map['staff_id'] as int,
      position: map['position'] as int,
      teacherStaff:
          Staff.fromJson(map['staff_detail'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory MajorContact.fromJson(String source) =>
      MajorContact.fromMap(json.decode(source) as Map<String, dynamic>);
}
