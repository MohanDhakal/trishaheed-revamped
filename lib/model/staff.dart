// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class StaffDetail {
  late int currentPage;
  late int lastPage;
  List<Staff> staffs = [];
  StaffDetail(this.currentPage, this.lastPage, this.staffs);

  factory StaffDetail.fromJson(Map<String, dynamic> json) {
    List<Staff> local = <Staff>[];
    for (var element in json["data"]) {
      final staff = Staff.fromJson(element);
      local.add(staff);
    }
    return StaffDetail(json["current_page"], json["last_page"], local);
  }
}

class Staff extends Equatable {
  int? id;
  String fullName;
  String teacherLevel;
  String majorSubject;
  String? email;
  String? contact;
  String? imageUrl;
  String dob;
  String address;
  String post;
  String rank;
  int isActive;
  String joinedAt;
  String jobType;
  bool? onFocused = false;
  Staff({
    required this.fullName,
    required this.teacherLevel,
    required this.majorSubject,
    required this.dob,
    required this.address,
    required this.post,
    required this.rank,
    required this.isActive,
    required this.joinedAt,
    required this.jobType,
    this.id,
    this.contact,
    this.email,
    this.imageUrl,
    this.onFocused,
  });
  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      fullName: json["full_name"],
      teacherLevel: json["level"],
      majorSubject: json["major_in"],
      dob: json["dob"],
      address: json["address"],
      post: json["post"],
      rank: json["rank"],
      isActive: json["is_active"],
      joinedAt: json["joined_at"],
      jobType: json["job_type"],
      email: json["email"],
      contact: json["phone_number"],
      imageUrl: json["image_uri"],
      id: json["id"],
    );
  }

  @override
  List<Object?> get props => [
        this.fullName,
        this.teacherLevel,
        this.majorSubject,
        this.dob,
        this.address,
        this.post,
        this.rank,
        this.isActive,
        this.joinedAt,
        this.jobType,
        this.id,
        this.contact,
        this.email,
        this.imageUrl,
        this.onFocused,
      ];
}
