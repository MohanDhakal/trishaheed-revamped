import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Exam {
  int? id;
  String term;
  int academicYear;
  String startDate;
  Exam({
    this.id,
    required this.term,
    required this.academicYear,
    required this.startDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': term,
      'academic_year': academicYear,
      'start_date': startDate,
    };
  }

  factory Exam.fromMap(Map<String, dynamic> map) {
    return Exam(
      id: map['id'] != null ? map['id'] as int : null,
      term: map['type'] as String,
      academicYear: map['academic_year'] as int,
      startDate: map['start_date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Exam.fromJson(String source) =>
      Exam.fromMap(json.decode(source) as Map<String, dynamic>);
}
