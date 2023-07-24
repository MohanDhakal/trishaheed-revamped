class Student {
  int? id;
  String fullName;
  String? image_url;
  int grade;
  int rollNumber;
  int currentRank;
  String? email;
  String dob;
  String joinedAt;
  String? majorSubject;
  int is_active;
  String? address;
  String? guardianContact;

  Student(
    this.fullName,
    this.grade,
    this.rollNumber,
    this.currentRank,
    this.dob,
    this.joinedAt,
    this.is_active, [
    this.id,
    this.address,
    this.guardianContact,
    this.email,
    this.image_url,
    this.majorSubject,
  ]);
  factory Student.fromJson(Map<String, dynamic> data) {
    return Student(
      data["full_name"],
      data["grade"],
      data["roll_number"],
      data["current_rank"],
      data["dob"],
      data["joined_at"],
      data["is_active"],
      data["id"],
      data["address"],
      data["guardian_contact"],
      data["email"],
      data["image_uri"],
      data["major_subject"],
    );
  }
}
