class Student {
  String name;
  int grade;
  int rollNumber;
  double latest_Gpa;
  DateTime? dob;
  String? parentName;
  DateTime? joinedDate;
  Student({
    required this.name,
    required this.grade,
    required this.rollNumber,
    required this.latest_Gpa,
    this.parentName,
    this.dob,
    this.joinedDate,
  });
}
