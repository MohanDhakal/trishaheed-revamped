class Album {
  int? id;
  late String name;
  String? description;

  Album(this.name, this.description, [this.id]);
  Album.fromJson(Map<String, dynamic> json) {
    this.id = json["albumId"];
    this.name = json["albumName"];
    this.description = json["albumDescription"];
  }
  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "description": this.description,
    };
  }
}
