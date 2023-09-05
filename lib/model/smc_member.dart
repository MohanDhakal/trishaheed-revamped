class Member {
  int? id;
  String name;
  String? phoneNumber;
  String? email;
  String post;
  int rank;
  String address;
  String memberType;

  Member(
    this.id,
    this.name,
    this.phoneNumber,
    this.email,
    this.post,
    this.rank,
    this.address,
    this.memberType,
  );
  factory Member.fromJson(Map<String, dynamic> data) {
    return Member(
      data["id"],
      data["name"],
      data["phone"],
      data["email"],
      data["post"],
      data["rank"],
      data["address"],
      data["member_type"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "phone": this.phoneNumber,
      "email": this.email,
      "post": this.post,
      "rank": this.rank,
      "address": this.address,
      "member_type": this.memberType,
    };
  }
}
