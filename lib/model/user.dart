class User {
  int id;
  String name;
  String? email;
  User(this.id, this.name, [this.email]);
  factory User.fromJson(Map<String, dynamic> data) {
    print(data);
    return User(data["id"], data["name"], data["email"]);
  }
}
