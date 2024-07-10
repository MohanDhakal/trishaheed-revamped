// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Student {
  int? id;
  String fullName;
  String dob;
  String address;
  int currentRank;
  String majorSubject;
  String joinedAt;
  bool isActive;
  int rollNumber;
  int classId;
  int? contactId;
  int courseId;
  Uint8List? image;
  String? imageUri;

  Student({
    this.id,
    required this.fullName,
    required this.dob,
    required this.address,
    required this.currentRank,
    required this.majorSubject,
    required this.joinedAt,
    required this.isActive,
    required this.rollNumber,
    required this.classId,
    this.contactId,
    required this.courseId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'student_id': id,
      'full_name': fullName,
      'dob': dob,
      'address': address,
      'current_rank': currentRank,
      'major_subject': majorSubject,
      'joined_at': joinedAt,
      'is_active': isActive,
      'roll_number': rollNumber,
      'class_id': classId,
      'contact_id': contactId,
      'course_id': courseId,
      'image': image,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['student_id'] != null ? map['student_id'] as int : null,
      fullName: map['full_name'] as String,
      dob: map['dob'] as String,
      address: map['address'] as String,
      currentRank: map['current_rank'] as int,
      majorSubject: map['major_subject'] as String,
      joinedAt: map['joined_at'] as String,
      isActive: (map['is_active'] as int) == 1 ? true : false,
      rollNumber: map['roll_number'] as int,
      classId: map['class_id'] as int,
      contactId: map['contact_id'] != null ? map['contact_id'] as int : null,
      courseId: map['course_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);
}

class StudentWrapper {
  int totalStudents;
  int perPage;
  int lastPage;
  int currentPage;
  String? nextPageUrl;
  String? prevPageUrl;
  List<Student> student;

  StudentWrapper({
    required this.totalStudents,
    required this.perPage,
    required this.currentPage,
    required this.student,
    required this.lastPage,
    this.nextPageUrl,
  });
}

class Grade {
  int id;
  int classNum;
  String className;
  String? createdAt;
  String? updatedAt;
  Grade({
    required this.id,
    required this.classNum,
    required this.className,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'class_id': id,
      'class_num': classNum,
      'class_name': className,
      "created_at": createdAt,
      "updated_at": updatedAt
    };
  }

  factory Grade.fromMap(Map<String, dynamic> map) {
    return Grade(
      id: map['class_id'] as int,
      classNum: map['class_num'] as int,
      className: map['class_name'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}
class StudentContact {
  int contactId;
  int studentId;
 String email;
 String phoneNumber;
 String guardianContact;
  StudentContact({
    required this.contactId,
    required this.studentId,
    required this.email,
    required this.phoneNumber,
    required this.guardianContact,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'contact_id': contactId,
      'student_id': studentId,
      'email': email,
      'phone_numebr': phoneNumber,
      'guardian_contact_number': guardianContact,
    };
  }

  factory StudentContact.fromMap(Map<String, dynamic> map) {
    return StudentContact(
      contactId: map['contact_id'] as int,
      studentId: map['student_id'] as int,
      email: map['email'] as String,
      phoneNumber: map['phone_number'] as String,
      guardianContact: map['guardian_contact_number'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentContact.fromJson(String source) => StudentContact.fromMap(json.decode(source) as Map<String, dynamic>);
}
