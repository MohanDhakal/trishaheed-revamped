class Slug {
  int id;
  String name;

  Slug(this.id, this.name);

  Map<String, dynamic> toJson() {
    return {"id": this.id, "name": this.name};
  }

  factory Slug.fromJson(Map<dynamic, dynamic> d) {
    return Slug(int.parse(d["id"]), d["name"]);
  }
}
