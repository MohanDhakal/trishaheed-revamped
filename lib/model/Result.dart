import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Result {
  int? id;
  int studentId;
  int examId;
  int subjectId;
  double marks;
  String marksType;
  String? subjectName;
  String? grade;
  double? credit;
  double? gradePoint;
  String? symbolNo;
  String? subjectCode;

  Result({
    required this.studentId,
    required this.examId,
    required this.subjectId,
    required this.marks,
    required this.marksType,
    this.grade,
    this.subjectName,
    this.credit,
    this.gradePoint,
    this.id,
    this.symbolNo,
    this.subjectCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'student_id': studentId,
      'exam_id': examId,
      'subject_id': subjectId,
      'marks': marks,
      'marks_type': marksType,
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      id: map['id'] as int,
      studentId: map['student_id'] as int,
      examId: map['exam_id'] as int,
      subjectId: map['subject_id'] as int,
      marks: map['marks'] as double,
      marksType: map['marks_type'] as String,
      grade: map['grade'] as String,
      credit: map['credit'] != null ? map['credit'] as double : null,
      subjectName: map['subject_name'] as String,
      gradePoint:
          map['grade_point'] != null ? map['grade_point'] as double : null,
      subjectCode: map['subject_code'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Result.fromJson(String source) =>
      Result.fromMap(json.decode(source) as Map<String, dynamic>);
}
